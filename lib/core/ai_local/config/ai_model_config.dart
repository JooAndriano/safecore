/// Configuration for the local AI model (LFM2.5-1.2B-Instruct)
/// Handles model paths, quantization, and platform-specific settings.
class AiModelConfig {
  AiModelConfig._();

  /// Model filename in GGUF format (Q4_K_M quantization)
  static const String modelName = 'LFM2.5-1.2B-Instruct.Q4_K_M.gguf';

  /// Default model path relative to assets
  static const String defaultAssetPath = 'assets/models/';

  /// Expected model file size (~2.3GB for Q4_K_M)
  static const int expectedModelSizeBytes = 2300000000;

  /// Maximum context window (number of tokens)
  static const int maxContextTokens = 2048;

  /// Maximum tokens to generate per response
  static const int maxNewTokens = 128;

  /// Temperature for generation (lower = more deterministic)
  static const double temperature = 0.7;

  /// Top-p sampling
  static const double topP = 0.9;

  /// Number of threads to use (Android mid-range target: 4)
  static const int nThreads = 4;

  /// Batch size for context processing
  static const int batchSize = 512;

  /// GPU acceleration flag (iOS optional, Android false by default)
  static const bool useGpu = false;

  /// Model load timeout in seconds
  static const int loadTimeoutSeconds = 30;

  /// Platform-specific settings
  static const Map<String, dynamic> platformSettings = {
    'android': {
      'useAarch64': true,
      'sharedMemory': true,
    },
    'ios': {
      'useMetal': true,
      'sharedMemory': true,
    },
  };
}