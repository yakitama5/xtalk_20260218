import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xtalk_20260218/config/theme.dart';
import 'package:xtalk_20260218/widgets/animated_stamp_widget.dart';
import 'package:xtalk_20260218/widgets/phone_frame_widget.dart';
import 'package:xtalk_20260218/widgets/slack_message_widget.dart';

class InteractiveChatSlide extends StatefulWidget {
  const InteractiveChatSlide({super.key});

  @override
  State<InteractiveChatSlide> createState() => _InteractiveChatSlideState();
}

class _InteractiveChatSlideState extends State<InteractiveChatSlide> {
  bool _showStamp = false;

  void _onChatSequenceComplete() {
    setState(() {
      _showStamp = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.custom(
      configuration: const FlutterDeckSlideConfiguration(
        route: '/interactive-chat',
        title: 'Communication is Key',
        header: FlutterDeckHeaderConfiguration(title: 'Before Coding...'),
      ),
      builder: (context) {
        return Stack(
          children: [
            // Main Content (Split Layout)
            Row(
              children: [
                // Left Side
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'その機能、\n本当に必要ですか？',
                          style: GoogleFonts.notoSansJp(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: PresentationTheme.primaryColor,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          '実装する前に\nチャット一本で解決することも。',
                          style: GoogleFonts.notoSansJp(
                            fontSize: 28,
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 48),
                        _buildFeatureRow(Icons.chat, '仕様の意図を確認'),
                        const SizedBox(height: 16),
                        _buildFeatureRow(Icons.money_off, '不要な開発コスト ¥0'),
                        const SizedBox(height: 16),
                        _buildFeatureRow(Icons.thumb_up, 'エンジニアの信頼度 UP'),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.touch_app, color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                '右の画面でメッセージを送ってみよう 👉',
                                style: GoogleFonts.notoSansJp(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Right Side
                Expanded(
                  flex: 6,
                  child: Center(
                    child: PhoneFrameWidget(
                      child: InteractiveChatDemo(
                        onSequenceComplete: _onChatSequenceComplete,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Global Stamp Overlay
            if (_showStamp) const Center(child: AnimatedStampWidget()),
          ],
        );
      },
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: PresentationTheme.successColor, size: 32),
        const SizedBox(width: 16),
        Text(
          text,
          style: GoogleFonts.notoSansJp(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class InteractiveChatDemo extends StatefulWidget {
  final VoidCallback onSequenceComplete;

  const InteractiveChatDemo({super.key, required this.onSequenceComplete});

  @override
  State<InteractiveChatDemo> createState() => _InteractiveChatDemoState();
}

class _InteractiveChatDemoState extends State<InteractiveChatDemo> {
  final List<SlackMessageWidget> _messages = []; // Widgetの型を指定
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  bool _isSequenceFinished = false;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSend() async {
    if (_textController.text.isEmpty) return;

    final text = _textController.text;
    _textController.clear();

    setState(() {
      // 1. 自分: メッセージ送信
      _messages.add(SlackMessageWidget(text: text, isMe: true));
    });
    _scrollToBottom();

    // 2. 1秒待機 -> 👀リアクション
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    setState(() {
      final lastMsg = _messages.last;
      _messages.removeLast();
      _messages.add(
        SlackMessageWidget(
          text: lastMsg.text,
          isMe: lastMsg.isMe,
          reactions: const [ReactionData('👀', 1)],
        ),
      );
    });

    // 3. 1秒待機 -> 入力中...
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    setState(() {
      _isTyping = true;
    });
    _scrollToBottom();

    // 4. 5秒待機 -> 返信
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;

    setState(() {
      _isTyping = false;
      // 相手: 返信
      _messages.add(
        const SlackMessageWidget(
          text: 'あ、以前の管理画面の仕様書コピペしただけなんで消していいですよ！\nそもそも不要です！',
          isMe: false,
        ),
      );
    });
    _scrollToBottom();

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    if (!_isSequenceFinished) {
      _isSequenceFinished = true;
      widget.onSequenceComplete();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Slack Theme Colors
    const slackAppBarColor = Color(0xFF4A154B);
    const slackBackgroundColor = Colors.white;

    return Scaffold(
      backgroundColor: slackBackgroundColor,
      // Custom Header to fit in Phone Frame
      body: Column(
        children: [
          // Custom App Bar Area
          Container(
            color: slackAppBarColor,
            padding: const EdgeInsets.only(
              top: 40,
              bottom: 10,
              left: 16,
              right: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '# project-x-design',
                        style: GoogleFonts.notoSansJp(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.info_outline, color: Colors.white),
              ],
            ),
          ),
          // Chat Body
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return const SlackMessageWidget(
                    text: '',
                    isMe: false,
                    isTyping: true,
                  );
                }
                return _messages[index];
              },
            ),
          ),
          // Input Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.add, color: Colors.grey, size: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Message #project-x-design',
                      hintStyle: GoogleFonts.roboto(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      isDense: true,
                    ),
                    style: const TextStyle(color: Colors.black),
                    onSubmitted: (_) => _handleSend(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _handleSend,
                  icon: const Icon(Icons.send),
                  color: const Color(0xFF007A5A), // Slack Green
                  tooltip: '送信',
                ),
              ],
            ),
          ),
          // Home Indicator Area spacing
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
