import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xtalk_20260218/config/theme.dart';
import 'package:xtalk_20260218/widgets/animated_stamp_widget.dart';
import 'package:xtalk_20260218/widgets/phone_frame_widget.dart';
import 'package:xtalk_20260218/widgets/slack_message_widget.dart';

class InteractiveChatSlide extends FlutterDeckSlideWidget {
  const InteractiveChatSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/interactive-chat',
          title: 'Communication is Key',
          header: FlutterDeckHeaderConfiguration(title: 'Before Coding...'),
          speakerNotes: '''
ここでふと立ち返ります。
「本当にこの機能必要か？」と。

業務ルールで決まっているいくつかのステータス変遷に対して「ソートしたい！」というニーズはあまり思い浮かびません。
あるとしたら「完了だけ見たい」といった「絞り込み」の方でしょう。

ここはひとつ聞いてみましょう！
チャットで顧客に連絡してみます。

（チャットを打つ）
（送信ボタンを押す）
（待ち時間は適当に話す）

……来ました！
「コピペだから消していいよ」とのことです。
結果的に機能は不要、コストは0円になりました。

補足ですが、
実際の現場では「ソートではなく、絞り込みが必要」という結末でしたが、
違う形で実装されそうだったニーズを、正しい形に修正出来たのでよかったです。
''',
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) => const _InteractiveChatContent(),
    );
  }
}

class _InteractiveChatContent extends StatefulWidget {
  const _InteractiveChatContent();

  @override
  State<_InteractiveChatContent> createState() =>
      _InteractiveChatContentState();
}

class _InteractiveChatContentState extends State<_InteractiveChatContent> {
  bool _showStamp = false;

  void _onChatSequenceComplete() {
    setState(() {
      _showStamp = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      style: GoogleFonts.kiwiMaru(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: PresentationTheme.primaryDarkColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '実装する前に\nチャット一本で解決するかも...？',
                      style: GoogleFonts.kiwiMaru(
                        fontSize: 28,
                        color: PresentationTheme.textColor,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: PresentationTheme.primaryColor.withValues(
                          alpha: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: PresentationTheme.primaryColor.withValues(
                            alpha: 0.4,
                          ),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.touch_app,
                            color: PresentationTheme.primaryDarkColor,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '右の画面でメッセージを送ってみよう 👉',
                            style: GoogleFonts.kiwiMaru(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: PresentationTheme.textColor,
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
              top: 50,
              bottom: 12,
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
                        style: GoogleFonts.kiwiMaru(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.info_outline, color: Colors.white, size: 28),
              ],
            ),
          ),
          // Chat Body
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 10, bottom: 20),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.add, color: Colors.grey, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Message #project-x-design',
                      hintStyle: GoogleFonts.kiwiMaru(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      isDense: true,
                    ),
                    style: GoogleFonts.kiwiMaru(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    onSubmitted: (_) => _handleSend(),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _handleSend,
                  icon: const Icon(Icons.send, size: 28),
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
