import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/themes/themes.dart';
import '../../../core/ai_local/ai_local.dart';

/// AI Assistant Screen - Antarmuka Chat untuk tanya jawab darurat
class AiAssistantView extends StatefulWidget {
  const AiAssistantView({super.key});

  @override
  State<AiAssistantView> createState() => _AiAssistantViewState();
}

class _AiAssistantViewState extends State<AiAssistantView> {
  final AiController aiController = Get.find<AiController>();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isTyping = false.obs;

  @override
  void initState() {
    super.initState();
    // Welcome message
    messages.add(ChatMessage(
      text: 'Halo! Saya asisten SAFECORE. Saya bisa membantu menjelaskan langkah darurat atau menjawab pertanyaan seputar keselamatan Anda. Apa yang bisa saya bantu?',
      isFromUser: false,
    ));
  }

  // MARK: Logic

  Future<void> _sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    textController.clear();
    messages.add(ChatMessage(text: text, isFromUser: true));
    _scrollToBottom();

    isTyping.value = true;

    try {
      // Simulate/Use AI Response
      // In a real implementation, this would call aiController.generateResponse(text)
      final response = await _getAIResponse(text);
      messages.add(ChatMessage(text: response, isFromUser: false));
    } catch (e) {
      messages.add(ChatMessage(
        text: 'Maaf, saya sedang mengalami kendala teknis. Silakan coba lagi nanti.',
        isFromUser: false,
      ));
    } finally {
      isTyping.value = false;
      _scrollToBottom();
    }
  }

  Future<String> _getAIResponse(String query) async {
    // Basic offline logic for demonstration
    await Future.delayed(const Duration(seconds: 1));
    final q = query.toLowerCase();
    
    if (q.contains('gempa')) {
      return 'Jika terjadi gempa, ingat: DROP, COVER, dan HOLD ON. Berlutut, lindungi kepala di bawah meja, dan pegangan sampai getaran berhenti.';
    } else if (q.contains('pingsan')) {
      return 'Untuk orang pingsan, baringkan di tempat datar, tinggikan kaki sekitar 30cm, dan pastikan sirkulasi udara baik. Jangan berikan minum sampai sadar penuh.';
    } else if (q.contains('terima kasih') || q.contains('thanks')) {
      return 'Sama-sama! Tetap waspada dan jaga keselamatan Anda.';
    }
    
    return 'Saya memahami pertanyaan Anda tentang "$query". Selalu prioritaskan keselamatan diri dan hubungi layanan darurat 112 jika dalam bahaya mendesak.';
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // MARK: Build

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            AppIcon(icon: FontAwesomeIcons.robot, color: AppColors.lightText, size: 20),
            const SizedBox(width: 12),
            Text(
              'Asisten AI',
              style: AppTypography.h3.copyWith(color: AppColors.lightText),
            ),
          ],
        ),
        backgroundColor: AppColors.infoBlue,
        iconTheme: const IconThemeData(color: AppColors.lightText),
        actions: [
          Obx(() => Container(
            margin: const EdgeInsets.only(right: 16),
            child: FaIcon(
              FontAwesomeIcons.solidCircle,
              size: 8,
              color: aiController.isModelLoaded ? AppColors.successGreen : AppColors.secondaryText,
            ),
          )),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages Area
          Expanded(
            child: Obx(() => ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildChatBubble(messages[index]);
              },
            )),
          ),

          // Typing Indicator
          Obx(() => isTyping.value
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  alignment: Alignment.centerLeft,
                  child: AppText.body3('Asisten sedang mengetik...', color: AppColors.secondaryText),
                )
              : const SizedBox.shrink()),

          // Suggestions
          _buildSuggestions(),

          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    final isUser = message.isFromUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: Get.width * 0.75),
        decoration: BoxDecoration(
          color: isUser 
              ? AppColors.infoBlue 
              : Theme.of(context).brightness == Brightness.dark 
                  ? AppColors.darkSurfaceVariant 
                  : AppColors.lightSurfaceVariant,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child: AppText.body1(
          message.text,
          color: isUser 
              ? AppColors.lightText 
              : Theme.of(context).brightness == Brightness.dark 
                  ? AppColors.lightText 
                  : AppColors.inverseText,
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    final suggestions = ['Langkah gempa', 'Bantuan pingsan', 'Cara evakuasi'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(suggestions[index]),
              onPressed: () {
                textController.text = suggestions[index];
                _sendMessage();
              },
              backgroundColor: AppColors.darkSurface,
              labelStyle: const TextStyle(color: AppColors.lightText, fontSize: 12),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: AppColors.secondaryText.withValues(alpha: 0.2))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.darkSurface 
                    : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Tanya asisten...',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: AppColors.infoBlue,
            child: IconButton(
              icon: FaIcon(FontAwesomeIcons.paperPlane, size: 18, color: AppColors.lightText),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

// MARK: Models

class ChatMessage {
  final String text;
  final bool isFromUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isFromUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
