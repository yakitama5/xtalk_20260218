import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xtalk_20260218/config/theme.dart';

class ProcessFlowWidget extends StatelessWidget {
  const ProcessFlowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Database
            _buildNode(
              icon: Icons.storage,
              title: 'Database',
              subtitle: '1,000,000 Records',
              color: PresentationTheme.primaryDarkColor,
            ),
            _buildArrow(),

            // Fetch & Calculate (Problem)
            _buildCard(
              title: '全件フェッチ & メモリ内計算',
              subtitle: 'computed_status = ...',
              color: PresentationTheme.warningColor,
              textColor: PresentationTheme.textColor,
              icon: Icons.memory,
            ),
            _buildArrow(),

            // Sort & Pagination
            _buildCard(
              title: 'ソート & 10件抽出',
              subtitle: '.sort(...).take(10)',
              color: PresentationTheme.warningColor,
              textColor: PresentationTheme.textColor,
              icon: Icons.sort,
            ),
            _buildArrow(),

            // Result (Failure)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(
                  color: PresentationTheme.warningColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
                color: PresentationTheme.warningColor.withValues(alpha: 0.1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.timer_off,
                    color: PresentationTheme.warningColor,
                    size: 48,
                  ),
                  const Gap(16),
                  Text(
                    'Time Out / High Load',
                    style: GoogleFonts.kiwiMaru(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: PresentationTheme.warningDarkColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNode({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 64, color: color),
        const Gap(8),
        Text(
          title,
          style: GoogleFonts.kiwiMaru(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.kiwiMaru(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required Color color,
    required Color textColor,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 32),
          const Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.kiwiMaru(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: textColor.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Icon(Icons.arrow_downward, color: Colors.grey[600], size: 32),
    );
  }
}
