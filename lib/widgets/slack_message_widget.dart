import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SlackMessageWidget extends StatelessWidget {
  final String text;
  final bool isMe;
  final bool isTyping;

  final List<ReactionData> reactions;

  const SlackMessageWidget({
    super.key,
    required this.text,
    required this.isMe,
    this.isTyping = false,
    this.reactions = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (isTyping) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(
          '入力中...',
          style: GoogleFonts.kiwiMaru(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFF1976D2) : const Color(0xFFE91E63),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Icon(
              isMe ? Icons.person : Icons.support_agent,
              color: Colors.white,
              size: 24,
            ),
          ),
          const Gap(14),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      isMe ? 'Me' : 'Product Manager',
                      style: GoogleFonts.kiwiMaru(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      '10:23 AM',
                      style: GoogleFonts.kiwiMaru(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const Gap(6),
                Text(
                  text,
                  style: GoogleFonts.kiwiMaru(
                    fontSize: 18,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                if (reactions.isNotEmpty) ...[
                  const Gap(6),
                  Wrap(
                    spacing: 6,
                    children: reactions
                        .map((r) => _buildReaction(r.emoji, r.count))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReaction(String emoji, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Text(
        '$emoji $count',
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }
}

class ReactionData {
  final String emoji;
  final int count;

  const ReactionData(this.emoji, this.count);
}
