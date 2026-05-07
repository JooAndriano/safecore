import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ai_controller.dart';
import '../config/ai_model_config.dart';
import '../models/ai_response.dart';

/// AI Bottom Sheet widget for Emergency Mode.
/// Provides a lightweight, non-intrusive AI assistant interface.
/// Opens when user taps "Tanya AI" button on any emergency step.
class AiBottomSheet extends StatefulWidget {
  /// Whether to automatically load model when opening
  final bool autoLoadModel;

  /// Callback when AI response is received
  final Function(String)? onResponse;

  const AiBottomSheet({
    super.key,
    this.autoLoadModel = true,
    this.onResponse,
  });

  @override
  State<AiBottomSheet> createState() => _AiBottomSheetState();
}

class _AiBottomSheetState extends State<AiBottomSheet> {
  late final AiController _aiController;
  final TextEditingController _questionController = TextEditingController();
  final FocusNode _questionFocus = FocusNode();
  bool _isModelLoading = false;

  @override
  void initState() {
    super.initState();
    _aiController = Get.find<AiController>();
    
    // Check if AI is available, if not try to load
    if (!widget.autoLoadModel && !_aiController.isAiAvailable.value) {
      _checkAndLoadModel();
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _questionFocus.dispose();
    super.dispose();
  }

  Future<void> _checkAndLoadModel() async {
    if (!_aiController.isAiAvailable.value) {
      setState(() => _isModelLoading = true);
      await _aiController.loadModel();
      setState(() => _isModelLoading = false);
    }
  }

  /// Open the AI bottom sheet with optional pre-filled question.
    static Future<String?> show({
      required BuildContext context,
      String initialQuestion = '',
      bool autoLoadModel = true,
    }) async { // Added async keyword
      return Get.bottomSheet<String>(
        AiBottomSheet(
          autoLoadModel: autoLoadModel,
        ),
        backgroundColor: const Color(0xFF2C2C2E),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      );
    }

  Future<void> _handleQuestion() async {
    final question = _questionController.text.trim();
    if (question.isEmpty) return;

    // Auto-load model if needed
    if (widget.autoLoadModel && !_aiController.isModelLoaded) {
      await _aiController.loadModel();
    }

    await _aiController.askQuestion(question);
    
    // Keep question in field for follow-up
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _handleExplain() async {
    if (widget.autoLoadModel && !_aiController.isModelLoaded) {
      await _aiController.loadModel();
    }

    await _aiController.explainCurrentStep();
    
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAvailable = _aiController.isAiAvailable.value;
    final isGenerating = _aiController.isGenerating.value;
    final response = _aiController.latestResponse.value;
    final hasError = _aiController.errorMessage.isNotEmpty;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF8E8E93),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.smart_toy_rounded,
                  color: Color(0xFF5AC8FA),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  '❓ Tanya AI',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const Spacer(),
                // Status indicator
                _buildStatusIndicator(),
                const SizedBox(width: 8),
                // Close button
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ],
            ),
          ),

          // Body content
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Explain button row
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 36,
                          child: ElevatedButton.icon(
                            onPressed: isAvailable && !isGenerating
                                ? _handleExplain
                                : null,
                            icon: const Icon(
                              Icons.help_outline_rounded,
                              size: 16,
                            ),
                            label: const Text(
                              'Jelaskan Langkah',
                              style: TextStyle(fontSize: 13),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5AC8FA),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Load model button (if not loaded)
                      if (!_aiController.isModelLoaded && !isGenerating)
                        TextButton.icon(
                          onPressed: _checkAndLoadModel,
                          icon: const Icon(
                            Icons.download_rounded,
                            size: 16,
                          ),
                          label: const Text(
                            'Muat Model',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // AI Response display
                  if (response != null) ...[
                    _buildResponseCard(response, hasError),
                    const SizedBox(height: 12),
                  ],

                  // Error message
                  if (hasError && response == null) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF3B30).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _aiController.errorMessage,
                        style: const TextStyle(
                          color: Color(0xFFFF3B30),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Question input row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _questionController,
                          focusNode: _questionFocus,
                          decoration: InputDecoration(
                            hintText: 'Tanya tentang langkah ini...',
                            hintStyle: const TextStyle(
                              color: Color(0xFF8E8E93),
                              fontSize: 14,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF3A3A3C),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          maxLines: null,
                          minLines: 1,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _handleQuestion(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        onPressed: isAvailable && !isGenerating
                            ? _handleQuestion
                            : null,
                        icon: isGenerating
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFFFFFFFF),
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.send_rounded,
                                size: 18,
                              ),
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF5AC8FA),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Bottom padding for safe area
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: const SizedBox(height: 8),
            ),
          ),
        ],
      ),
    );
  }

  /// Build status indicator widget.
  Widget _buildStatusIndicator() {
    if (_isModelLoading || _aiController.isLoadingModel.value) {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: const Color(0xFFFF9500),
          shape: BoxShape.circle,
        ),
      );
    } else if (_aiController.isModelLoaded) {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: const Color(0xFF34C759),
          shape: BoxShape.circle,
        ),
      );
    } else if (_aiController.isAiAvailable.value) {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: const Color(0xFF8E8E93),
          shape: BoxShape.circle,
        ),
      );
    } else {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: const Color(0xFFFF3B30),
          shape: BoxShape.circle,
        ),
      );
    }
  }

  /// Build response card widget.
  Widget _buildResponseCard(AiResponse response, bool hasError) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: response.isSuccess
              ? const Color(0xFF5AC8FA).withOpacity(0.3)
              : const Color(0xFFFF3B30).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.smart_toy_rounded,
                color: Color(0xFF5AC8FA),
                size: 14,
              ),
              const SizedBox(width: 6),
              const Text(
                'AI',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5AC8FA),
                ),
              ),
              const Spacer(),
              if (response.isSuccess)
                Text(
                  '${response.generationTimeMs.toStringAsFixed(0)}ms',
                  style: const TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 10,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            response.text.isEmpty || hasError
                ? (_aiController.errorMessage.isNotEmpty
                    ? _aiController.errorMessage
                    : 'Menjawab...')
                : response.text,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: Color(0xFFFFFFFF),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}