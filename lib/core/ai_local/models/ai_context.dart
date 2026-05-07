/// AI context data that is sent to the local model.
/// Contains only essential information - NOT full app access.
class AiContext {
  /// Current disaster type (e.g., 'earthquake', 'tsunami', 'fire')
  final String disasterType;

  /// Current step number in emergency protocol
  final int currentStep;

  /// Total steps in current protocol
  final int totalSteps;

  /// Current step instruction from JSON protocol
  final String currentStepInstruction;

  /// Previous steps already completed
  final List<String> completedSteps;

  /// Raw context data from JSON (key-value pairs)
  final Map<String, dynamic> rawData;

  AiContext({
    required this.disasterType,
    required this.currentStep,
    required this.totalSteps,
    required this.currentStepInstruction,
    this.completedSteps = const [],
    this.rawData = const {},
  });

  /// Create from JSON protocol data
  factory AiContext.fromJson({
    required String disasterType,
    required int currentStep,
    required int totalSteps,
    required String currentStepInstruction,
    List<dynamic>? completedSteps,
    Map<String, dynamic>? rawData,
  }) {
    return AiContext(
      disasterType: disasterType,
      currentStep: currentStep,
      totalSteps: totalSteps,
      currentStepInstruction: currentStepInstruction,
      completedSteps: (completedSteps ?? []).cast<String>(),
      rawData: rawData ?? {},
    );
  }

  /// Convert to map for FFI serialization
  Map<String, dynamic> toMap() {
    return {
      'disaster_type': disasterType,
      'current_step': currentStep,
      'total_steps': totalSteps,
      'current_step_instruction': currentStepInstruction,
      'completed_steps': completedSteps,
      'raw_data': rawData,
    };
  }

  /// Create a copy with updated values
  AiContext copyWith({
    String? disasterType,
    int? currentStep,
    int? totalSteps,
    String? currentStepInstruction,
    List<String>? completedSteps,
    Map<String, dynamic>? rawData,
  }) {
    return AiContext(
      disasterType: disasterType ?? this.disasterType,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      currentStepInstruction: currentStepInstruction ?? this.currentStepInstruction,
      completedSteps: completedSteps ?? this.completedSteps,
      rawData: rawData ?? this.rawData,
    );
  }

  @override
  String toString() {
    return 'AiContext(disasterType: $disasterType, step: $currentStep/$totalSteps, instruction: $currentStepInstruction)';
  }
}