/// AI Local module for SAFECORE.
/// Provides lightweight local AI inference using llama.cpp and GGUF models.
/// Fully independent from the main emergency protocol logic.

export 'bindings/llama_ffi_bindings.dart';
export 'config/ai_model_config.dart';
export 'controllers/ai_controller.dart';
export 'models/ai_context.dart';
export 'models/ai_response.dart';
export 'services/ai_prompt_builder.dart';
export 'services/local_ai_service.dart';
export 'widgets/ai_bottom_sheet.dart';