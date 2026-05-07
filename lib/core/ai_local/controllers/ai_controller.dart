import 'package:get/get.dart';
import '../models/ai_context.dart';
import '../models/ai_response.dart';
import '../services/local_ai_service.dart';

/// GetX Controller for Local AI features.
/// Manages AI state, responses, and UI interactions.
/// Fully independent from main emergency protocol logic.
class AiController extends GetxController {
  final LocalAiService _aiService = LocalAiService();

  // UI State
  final RxBool isAiAvailable = false.obs;
  final RxBool isLoadingModel = false.obs;
  final RxBool isGenerating = false.obs;
  final RxString lastErrorMessage = ''.obs;

  // AI Data
  final Rxn<AiResponse> latestResponse = Rxn<AiResponse>();
  final Rxn<AiContext> currentContext = Rxn<AiContext>();
  final RxList<String> conversationHistory = <String>[].obs;

  // ==================== INITIALIZATION ====================

  /// Initialize the AI service (does NOT load model yet).
  @override
  void onInit() {
    super.onInit();
    _initializeService();
    _listenToResponses();
  }

  Future<void> _initializeService() async {
    try {
      await _aiService.initialize();
      isAiAvailable.value = _aiService.isAvailable;
    } catch (e) {
      lastErrorMessage.value = 'AI initialization failed: $e';
      isAiAvailable.value = false;
    }
  }

  void _listenToResponses() {
    _aiService.responseStream.listen((response) {
      latestResponse.value = response;
      if (response.isSuccess && response.text.isNotEmpty) {
        conversationHistory.add(response.text);
      }
    });
  }

  // ==================== MODEL LIFECYCLE ====================

  /// Load the model lazily when first needed.
  Future<bool> loadModel() async {
    isLoadingModel.value = true;
    try {
      final loaded = await _aiService.loadModel();
      if (loaded) {
        lastErrorMessage.value = '';
      } else {
        lastErrorMessage.value = _aiService.lastError ?? 'Failed to load model';
      }
      return loaded;
    } catch (e) {
      lastErrorMessage.value = 'Model load error: $e';
      return false;
    } finally {
      isLoadingModel.value = false;
    }
  }

  /// Unload the model to free memory.
  void unloadModel() {
    _aiService.unloadModel();
  }

  /// Dispose all resources.
  @override
  void onClose() {
    _aiService.dispose();
    super.onClose();
  }

  // ==================== AI ACTIONS ====================

  /// Ask AI to explain the current emergency step.
  Future<AiResponse> explainCurrentStep() async {
    isGenerating.value = true;
    try {
      final response = await _aiService.explainCurrentStep();
      latestResponse.value = response;
      if (!response.isSuccess) {
        lastErrorMessage.value = response.errorMessage ?? 'AI explanation failed';
      }
      return response;
    } catch (e) {
      lastErrorMessage.value = 'Explanation error: $e';
      return AiResponse.failure('Explanation error: $e');
    } finally {
      isGenerating.value = false;
    }
  }

  /// Ask AI a specific question about the current step.
  Future<AiResponse> askQuestion(String question) async {
    if (question.trim().isEmpty) {
      return AiResponse.failure('Please enter a question');
    }

    isGenerating.value = true;
    try {
      final response = await _aiService.askQuestion(question);
      latestResponse.value = response;
      
      // Add user question to history too
      conversationHistory.add('Q: $question');
      
      if (!response.isSuccess) {
        lastErrorMessage.value = response.errorMessage ?? 'AI question failed';
      }
      return response;
    } catch (e) {
      lastErrorMessage.value = 'Question error: $e';
      return AiResponse.failure('Question error: $e');
    } finally {
      isGenerating.value = false;
    }
  }

  /// Ask AI to clarify a specific step.
  Future<AiResponse> clarifyStep(int stepIndex) async {
    isGenerating.value = true;
    try {
      final response = await _aiService.clarifyStep(stepIndex);
      latestResponse.value = response;
      if (!response.isSuccess) {
        lastErrorMessage.value = response.errorMessage ?? 'AI clarification failed';
      }
      return response;
    } catch (e) {
      lastErrorMessage.value = 'Clarification error: $e';
      return AiResponse.failure('Clarification error: $e');
    } finally {
      isGenerating.value = false;
    }
  }

  // ==================== CONTEXT MANAGEMENT ====================

  /// Set the AI context from emergency protocol.
  void setAiContext({
    required String disasterType,
    required int currentStep,
    required int totalSteps,
    required String currentStepInstruction,
    List<String>? completedSteps,
    Map<String, dynamic>? rawData,
  }) {
    final context = AiContext(
      disasterType: disasterType,
      currentStep: currentStep,
      totalSteps: totalSteps,
      currentStepInstruction: currentStepInstruction,
      completedSteps: completedSteps ?? [],
      rawData: rawData ?? {},
    );
    
    currentContext.value = context;
    _aiService.setContext(context);
  }

  /// Update the current step in the AI context.
  void updateCurrentStep(int step) {
    if (currentContext.value != null) {
      _aiService.updateContext(currentStep: step);
      currentContext.value = _aiService.currentContext;
    }
  }

  /// Reset the AI context.
  void resetContext() {
    currentContext.value = null;
    _aiService.setContext(AiContext(
      disasterType: 'unknown',
      currentStep: 1,
      totalSteps: 1,
      currentStepInstruction: '',
    ));
  }

  // ==================== UTILITY ====================

  /// Clear the latest response.
  void clearResponse() {
    latestResponse.value = null;
  }

  /// Clear conversation history.
  void clearHistory() {
    conversationHistory.clear();
  }

  /// Check if AI can explain right now.
  bool canExplain() {
    return isAiAvailable.value && currentContext.value != null;
  }

  // ==================== GETTERS ====================

  /// Whether the model is loaded in memory.
  bool get isModelLoaded => _aiService.isLoaded;

  /// Latest error message.
  String get errorMessage => lastErrorMessage.value;

  /// Model path.
  String? get modelPath => _aiService.modelPath;

  /// Generation time of latest response.
  double get lastGenerationTime => latestResponse.value?.generationTimeMs ?? 0.0;
}