import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xtalk_20260218/config/theme.dart';
import 'package:xtalk_20260218/widgets/animated_stamp_widget.dart';
import 'package:xtalk_20260218/widgets/chat_bubble_widget.dart';

class InteractiveChatSlide extends FlutterDeckSlideWidget {
  const InteractiveChatSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/interactive-chat',
          title: 'Communication is Key',
          header: FlutterDeckHeaderConfiguration(title: 'Before Coding...'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const InteractiveChatDemo(),
    );
  }
}

class InteractiveChatDemo extends StatefulWidget {
  const InteractiveChatDemo({super.key});

  @override
  State<InteractiveChatDemo> createState() => _InteractiveChatDemoState();
}

class _InteractiveChatDemoState extends State<InteractiveChatDemo> {
  final List<Widget> _messages = [];
  bool _showSendButton = true;
  bool _showTyping = false;
  bool _showStamp = false;

  void _startDemo() async {
    setState(() {
      _showSendButton = false;
      // 自分: メッセージ送信
      _messages.add(
        const ChatBubbleWidget(
          text: 'このソート、実装コスト激高です。\n100万件全件計算になりますが、必須ですか？',
          isMe: true,
        ),
      );
      _showTyping = true;
    });

    // 待ち時間 (要件では5秒だが、デモテンポのため少し短縮して3秒)
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    setState(() {
      _showTyping = false;
      // 相手: 返信
      _messages.add(
        const ChatBubbleWidget(
          text: 'あ、以前の管理画面の仕様書コピペしただけなんで消していいですよ！\nそもそも不要です！',
          isMe: false,
        ),
      );
    });

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    setState(() {
      _showStamp = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(32),
                itemCount: _messages.length + (_showTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _showTyping) {
                    return const ChatBubbleWidget(
                      text: '',
                      isMe: false,
                      isTyping: true,
                    );
                  }
                  return _messages[index];
                },
              ),
            ),
            if (_showSendButton)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: _startDemo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PresentationTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    icon: const Icon(Icons.send, color: Colors.white, size: 32),
                    label: Text(
                      '仕様確認を送る',
                      style: GoogleFonts.notoSansJp(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (_showStamp) const Center(child: AnimatedStampWidget()),
      ],
    );
  }
}
