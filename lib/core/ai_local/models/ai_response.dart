/// Response from the local AI model inference.
class AiResponse {
  /// The generated text response
  final String text;

  /// Whether the response was successfully generated
  final bool isSuccess;

  /// Error message if generation failed
  final String? errorMessage;

  /// Number of tokens processed
  final int tokensProcessed;

  /// Number of tokens generated
  final int tokensGenerated;

  /// Generation time in milliseconds
  final double generationTimeMs;

  AiResponse({
    required this.text,
    this.isSuccess = true,
    this.errorMessage,
    this.tokensProcessed = 0,
    this.tokensGenerated = 0,
    this.generationTimeMs = 0.0,
  });

  /// Create a failure response
  factory AiResponse.failure(String errorMessage) {
    return AiResponse(
      text: '',
      isSuccess: false,
      errorMessage: errorMessage,
    );
  }

  /// Create an empty/loading response
  factory AiResponse.loading() {
    return AiResponse(
      text: 'Thinking...',
      tokensProcessed: 0,
      tokensGenerated: 0,
      generationTimeMs: 0.0,
    );
  }

  @override
  String toString() {
    if (!isSuccess) {
      return 'AiResponse(error: $errorMessage)';
    }
    return 'AiResponse(text: "$text", tokens: $tokensProcessed+${tokensGenerated}, time: ${generationTimeMs.toStringAsFixed(1)}ms)';
  }
}