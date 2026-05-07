import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/services.dart' show rootBundle;
import '../bindings/llama_ffi_bindings.dart';
import '../config/ai_model_config.dart';
import '../models/ai_context.dart';
import '../models/ai_response.dart';
import 'ai_prompt_builder.dart';

/// Local AI Service that manages the llama.cpp model lifecycle.
/// Handles lazy loading, inference, and memory management.
/// Fully independent from the main emergency protocol logic.
class LocalAiService {
  static final LocalAiService _instance = LocalAiService._internal();
  factory LocalAiService() => _instance;
  LocalAiService._internal();

  /// FFI bindings for llama.cpp
  LlamaFfiBindings? _bindings;

  /// Native context pointer
  int? _contextPtr;

  /// Whether the model is currently loaded in memory
  bool _isLoaded = false;

  /// Whether the service is currently initializing
  bool _isLoading = false;

  /// Current AI context
  AiContext? _currentContext;

  /// Stream controller for AI responses
  final StreamController<AiResponse> _responseController =
      StreamController<AiResponse>.broadcast();

  /// Subscription for response stream
  Stream<AiResponse> get responseStream => _responseController.stream;

  /// Latest response received
  AiResponse? _latestResponse;

  /// Model file path (resolved at runtime)
  String? _modelPath;

  /// Error handler
  String? _lastError;

  // ==================== LIFECYCLE ====================

  /// Initialize the service (does NOT load the model yet).
  /// Call this once during app initialization.
  Future<void> initialize() async {
    try {
      _bindings = LlamaFfiBindings(
        libraryPath: _getLibraryPath(),
        isLoaded: _checkLibraryAvailable(),
      );
      _modelPath = await _resolveModelPath();
    } catch (e) {
      _lastError = 'Initialization error: $e';
    }
  }

  /// Load the model lazily when first needed.
  Future<bool> loadModel() async {
    if (_isLoaded) return true;
    if (_isLoading) {
      // Wait for existing load
      await _waitForLoad();
      return _isLoaded;
    }

    _isLoading = true;

    try {
      final modelPath = _modelPath ?? await _resolveModelPath();

      if (!_bindings!.modelExists(modelPath)) {
        _lastError = 'Model file not found: $modelPath';
        _isLoading = false;
        return false;
      }

      // Create native context via FFI
      _contextPtr = _bindings!.createContext(
        modelPath: modelPath,
        nCtx: AiModelConfig.maxContextTokens,
        nBatch: AiModelConfig.batchSize,
        nThreads: AiModelConfig.nThreads,
        useGpu: AiModelConfig.useGpu,
      );

      if (_contextPtr != null) {
        _isLoaded = true;
        _lastError = null;
      } else {
        _lastError = 'Failed to create llama.cpp context';
      }
    } catch (e) {
      _lastError = 'Model load error: $e';
      _isLoaded = false;
    } finally {
      _isLoading = false;
    }

    return _isLoaded;
  }

  /// Unload the model to free memory.
  void unloadModel() {
    if (_contextPtr != null) {
      _bindings?.freeContext(_contextPtr);
      _contextPtr = null;
    }
    _isLoaded = false;
  }

  /// Dispose all resources.
  void dispose() {
    unloadModel();
    _responseController.close();
    _currentContext = null;
    _bindings = null;
  }

  // ==================== INFERENCE ====================

  /// Ask the AI to explain the current step.
  Future<AiResponse> explainCurrentStep() async {
    if (_currentContext == null) {
      return AiResponse.failure('No AI context set');
    }

    final prompt = AiPromptBuilder.buildExplainPrompt(_currentContext!);
    return _generateResponse(prompt);
  }

  /// Ask the AI a specific question.
  Future<AiResponse> askQuestion(String question) async {
    if (_currentContext == null) {
      return AiResponse.failure('No AI context set');
    }

    final prompt = AiPromptBuilder.buildQuestionPrompt(_currentContext!, question);
    return _generateResponse(prompt);
  }

  /// Ask the AI to clarify a specific step.
  Future<AiResponse> clarifyStep(int stepIndex) async {
    if (_currentContext == null) {
      return AiResponse.failure('No AI context set');
    }

    final prompt = AiPromptBuilder.buildClarifyPrompt(_currentContext!, stepIndex.toString());
    return _generateResponse(prompt);
  }

  /// Set the current AI context from emergency protocol.
  void setContext(AiContext context) {
    _currentContext = context;
  }

  /// Update context with new values.
  void updateContext({
    String? disasterType,
    int? currentStep,
    int? totalSteps,
    String? currentStepInstruction,
  }) {
    if (_currentContext != null) {
      _currentContext = _currentContext!.copyWith(
        disasterType: disasterType,
        currentStep: currentStep,
        totalSteps: totalSteps,
        currentStepInstruction: currentStepInstruction,
      );
    }
  }

  // ==================== INTERNAL ====================

  /// Generate a response from the model.
  Future<AiResponse> _generateResponse(String prompt) async {
    // Ensure model is loaded (lazy load)
    if (!_isLoaded) {
      final loaded = await loadModel();
      if (!loaded) {
        return AiResponse.failure(_lastError ?? 'Model not available');
      }
    }

    final startTime = DateTime.now().millisecondsSinceEpoch;

    try {
      // Generate via FFI
      final text = _bindings!.generate(
        contextPtr: _contextPtr!,
        prompt: prompt,
        maxTokens: AiModelConfig.maxNewTokens,
        temperature: AiModelConfig.temperature,
        topP: AiModelConfig.topP,
      );

      final endTime = DateTime.now().millisecondsSinceEpoch;
      final generationTime = endTime - startTime;

      final response = AiResponse(
        text: _sanitizeResponse(text),
        isSuccess: true,
        tokensProcessed: prompt.length,
        tokensGenerated: text.split(' ').length,
        generationTimeMs: generationTime.toDouble(),
      );

      _latestResponse = response;
      _responseController.add(response);
      return response;
    } catch (e) {
      return AiResponse.failure('Generation error: $e');
    }
  }

  /// Sanitize AI response text.
  String _sanitizeResponse(String text) {
    return text
        .replaceAll(RegExp(r'\s+'), ' ') // Normalize whitespace
        .trim()
        .replaceAll(RegExp(r'\n{3,}'), '\n\n'); // Limit newlines
  }

  /// Wait for model to finish loading.
  Future<void> _waitForLoad() async {
    while (_isLoading) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  /// Get the platform-specific library path.
  String _getLibraryPath() {
    if (io.Platform.isAndroid) {
      return 'libllama.so';
    } else if (io.Platform.isIOS) {
      return 'libllama.dylib';
    }
    return 'libllama.so';
  }

  /// Check if the native library is available.
  bool _checkLibraryAvailable() {
    try {
      final libPath = _getLibraryPath();
      // Try to open the library
      io.File(libPath).existsSync();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Resolve model path from assets or storage.
  Future<String> _resolveModelPath() async {
    // Check if model is in external storage first
    // Then fall back to asset bundle path
    return '${AiModelConfig.defaultAssetPath}${AiModelConfig.modelName}';
  }

  // ==================== GETTERS ====================

  /// Whether the model is loaded and ready.
  bool get isLoaded => _isLoaded;

  /// Whether the service is currently loading.
  bool get isLoading => _isLoading;

  /// Current AI context.
  AiContext? get currentContext => _currentContext;

  /// Latest response.
  AiResponse? get latestResponse => _latestResponse;

  /// Last error message.
  String? get lastError => _lastError;

  /// Model file path.
  String? get modelPath => _modelPath;

  /// Whether the AI service is available (library + model exist).
  bool get isAvailable {
    return _bindings != null &&
        (_modelPath == null || _bindings!.modelExists(_modelPath!));
  }
}