import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String text;
  final bool isMe;
  final bool isTyping;

  const ChatBubbleWidget({
    super.key,
    required this.text,
    required this.isMe,
    this.isTyping = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF1976D2) : const Color(0xFF424242),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isTyping
            ? _buildTypingIndicator()
            : Text(
                text,
                style: GoogleFonts.kiwiMaru(
                  fontSize: 18,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return SizedBox(
      width: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) => _Dot(index: index)),
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  final int index;
  const _Dot({required this.index});

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = (_controller.value + widget.index * 0.2) % 1.0;
        return Transform.translate(
          offset: Offset(0, -4 * (value < 0.5 ? value * 2 : (1 - value) * 2)),
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
