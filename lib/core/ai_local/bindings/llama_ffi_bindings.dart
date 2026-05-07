import 'dart:ffi' as ffi;
import 'dart:io' as io;

/// Token type
typedef LlamaToken = int;

/// Context pointer type
typedef LlamaContextPtr = int;

/// Callback for progress updates
typedef ProgressCallback = void Function(int current, int total);

/// FFI bindings interface for llama.cpp
/// Provides the contract for interacting with the native llama.cpp library.
class LlamaFfiBindings {
  /// Path to the native library (platform-specific)
  final String libraryPath;

  /// Whether the library is loaded successfully
  final bool isLoaded;

  /// Native library handle
  final ffi.DynamicLibrary? _library;

  LlamaFfiBindings({required this.libraryPath, this.isLoaded = false})
      : _library = isLoaded ? _loadLibrary() : null;

  static ffi.DynamicLibrary _loadLibrary() {
    if (io.Platform.isAndroid) {
      return ffi.DynamicLibrary.open('libllama.so');
    } else if (io.Platform.isIOS) {
      return ffi.DynamicLibrary.process();
    } else if (io.Platform.isMacOS) {
      return ffi.DynamicLibrary.process();
    } else {
      return ffi.DynamicLibrary.open('libllama.so');
    }
  }

  /// Initialize the llama.cpp context with model path and parameters
  /// Returns a context pointer (intptr_t in native code)
  LlamaContextPtr? createContext({
    required String modelPath,
    required int nCtx,
    required int nBatch,
    required int nThreads,
    required bool useGpu,
  }) {
    if (!isLoaded || _library == null) return null;
    // Native call placeholder - actual implementation in native code
    // llama_context* llama_init_from_file(
    //   const char *model_path,
    //   llama_context_params params
    // );
    return 0; // Placeholder
  }

  /// Process a prompt string and get tokenized input
  LlamaToken? tokenize(String prompt) {
    if (!isLoaded || _library == null) return null;
    // llama_tokenize(context, prompt.cstr, prompt.length, true, true)
    return 0; // Placeholder
  }

  /// Run inference on the model with given context
  String generate({
    required LlamaContextPtr contextPtr,
    required String prompt,
    required int maxTokens,
    required double temperature,
    required double topP,
  }) {
    if (!isLoaded) {
      return '[AI] Model not loaded';
    }
    // Placeholder - actual inference via FFI call
    return '';
  }

  /// Free the context and release memory
  void freeContext(LlamaContextPtr? contextPtr) {
    if (contextPtr != null && isLoaded) {
      // llama_free(context)
    }
  }

  /// Check if model file exists
  bool modelExists(String path) {
    return io.File(path).existsSync();
  }

  /// Get model file size
  int getModelSize(String path) {
    try {
      return io.File(path).lengthSync();
    } catch (e) {
      return 0;
    }
  }

  @override
  String toString() {
    return 'LlamaFfiBindings(loaded: $isLoaded, lib: $libraryPath)';
  }
}

/// Native function constants for llama.cpp FFI
class LlamaNativeFunctions {
  /// llama_context_params from json
  static const int llamaContextParamsSize = 64;
}
