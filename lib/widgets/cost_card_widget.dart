import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CostCardWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String price;
  final IconData icon;
  final Color color;

  const CostCardWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withValues(alpha: 0.5), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 64, color: color),
            ),
            const Gap(32),
            Text(
              title,
              style: GoogleFonts.notoSansJp(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subTitle,
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            const Divider(color: Colors.grey),
            const Gap(32),
            Text(
              price,
              style: GoogleFonts.notoSansJp(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            const Gap(8),
            Text(
              '実装・保守コスト',
              style: GoogleFonts.notoSansJp(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
