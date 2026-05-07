import '../models/ai_context.dart';

/// Builds prompts for the local AI model based on context and user query.
/// Ensures AI only explains current step - NOT full app access.
class AiPromptBuilder {
  /// System prompt that defines AI role and constraints
  static const String _systemPrompt = '''You are SAFECORE's local AI assistant for emergency protocols. 

RULES:
- You ONLY explain the current emergency step to the user
- You do NOT diagnose conditions or create new instructions
- You do NOT replace the emergency protocol - you only clarify it
- Keep responses SHORT and SIMPLE (max 3 sentences)
- Use clear, direct language suitable for emergency situations
- If asked about unrelated topics, redirect to the current step''';

  /// Build prompt for explaining the current step
  static String buildExplainPrompt(AiContext context) {
    final completedStepsText = context.completedSteps.isEmpty
        ? 'No steps completed yet.'
        : 'Completed steps: ${context.completedSteps.join(', ')}.';

    return '''${_systemPrompt}

Current situation: ${_formatDisasterType(context.disasterType)}
Current step ${context.currentStep}/${context.totalSteps}: ${context.currentStepInstruction}

$completedStepsText

Please explain what the user should do in this step in simple terms.''';
  }

  /// Build prompt for answering a specific user question
  static String buildQuestionPrompt(AiContext context, String userQuestion) {
    return '''${_systemPrompt}

Current situation: ${_formatDisasterType(context.disasterType)}
Current step ${context.currentStep}/${context.totalSteps}: ${context.currentStepInstruction}

User's question: "$userQuestion"

Please answer the question in relation to the current emergency step. Keep it short.''';
  }

  /// Build prompt for clarifying a previous step
  static String buildClarifyPrompt(AiContext context, String stepIndex) {
    return '''${_systemPrompt}

Current situation: ${_formatDisasterType(context.disasterType)}
Current step ${context.currentStep}/${context.totalSteps}: ${context.currentStepInstruction}

Please clarify step #$stepIndex for the user. Keep it simple and direct.''';
  }

  /// Format disaster type to readable string
  static String _formatDisasterType(String type) {
    return type
        .replaceAll('-', ' ')
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  /// Build a minimal prompt for quick responses
  static String buildMinimalPrompt(String currentInstruction) {
    return '''Explain this emergency step simply: "$currentInstruction"''';
  }

  /// Validate that the context is within bounds
  static bool validateContext(AiContext context) {
    if (context.disasterType.isEmpty) return false;
    if (context.currentStep < 1 || context.currentStep > context.totalSteps) {
      return false;
    }
    if (context.currentStepInstruction.isEmpty) return false;
    return true;
  }
}