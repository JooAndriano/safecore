/// Represents a single step in the emergency protocol.
/// Used by AI to understand current context.
class EmergencyStep {
  /// Step number (1-based)
  final int stepNumber;

  /// Step title/heading
  final String title;

  /// Step instruction text from JSON protocol
  final String instruction;

  /// Optional details for the step
  final String? details;

  /// Whether this step is completed
  final bool isCompleted;

  /// Additional context data for AI
  final Map<String, dynamic> aiContext;

  EmergencyStep({
    required this.stepNumber,
    required this.title,
    required this.instruction,
    this.details,
    this.isCompleted = false,
    this.aiContext = const {},
  });

  /// Create from JSON data
  factory EmergencyStep.fromJson({
    required int stepNumber,
    required String title,
    required String instruction,
    String? details,
    bool isCompleted = false,
    Map<String, dynamic>? aiContext,
  }) {
    return EmergencyStep(
      stepNumber: stepNumber,
      title: title,
      instruction: instruction,
      details: details,
      isCompleted: isCompleted,
      aiContext: aiContext ?? {},
    );
  }

  /// Convert to map for AI context serialization
  Map<String, dynamic> toMap() {
    return {
      'step_number': stepNumber,
      'title': title,
      'instruction': instruction,
      'details': details,
      'is_completed': isCompleted,
      'ai_context': aiContext,
    };
  }

  /// Create a copy with updated values
  EmergencyStep copyWith({
    int? stepNumber,
    String? title,
    String? instruction,
    String? details,
    bool? isCompleted,
    Map<String, dynamic>? aiContext,
  }) {
    return EmergencyStep(
      stepNumber: stepNumber ?? this.stepNumber,
      title: title ?? this.title,
      instruction: instruction ?? this.instruction,
      details: details ?? this.details,
      isCompleted: isCompleted ?? this.isCompleted,
      aiContext: aiContext ?? this.aiContext,
    );
  }

  @override
  String toString() {
    return 'EmergencyStep($stepNumber: $title - $instruction)';
  }
}