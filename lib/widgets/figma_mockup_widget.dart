import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FigmaMockupWidget extends StatelessWidget {
  const FigmaMockupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Window Control Bar (Figma like)
          Container(
            height: 32,
            color: const Color(0xFFE0E0E0),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                _buildCircle(Colors.red),
                const Gap(8),
                _buildCircle(Colors.amber),
                const Gap(8),
                _buildCircle(Colors.green),
              ],
            ),
          ),
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
              color: Color(0xFFF9F9F9),
            ),
            child: Row(
              children: [
                _buildCell('ID', width: 60, isHeader: true),
                _buildCell('Name', flex: 2, isHeader: true),
                _buildCell('CreatedAt', flex: 2, isHeader: true),
                _buildCell(
                  'Status ▼',
                  flex: 1,
                  isHeader: true,
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
          // Data Rows
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(10, (index) => _buildRow(index)),
              ),
            ),
          ),
          // Pagination Footer
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '1-10 of 1,000,000',
                  style: GoogleFonts.roboto(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                const Gap(16),
                const Icon(Icons.chevron_left, color: Colors.grey),
                const Gap(8),
                const Icon(Icons.chevron_right, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildRow(int index) {
    final isStripe = index % 2 == 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: isStripe ? Colors.white : const Color(0xFFFAFAFA),
      child: Row(
        children: [
          _buildCell('${1001 + index}', width: 60),
          _buildCell('Item ${String.fromCharCode(65 + index)}', flex: 2),
          _buildCell('2026-02-18', flex: 2),
          _buildCell(
            'Active',
            flex: 1,
            textColor: Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildCell(
    String text, {
    double? width,
    int? flex,
    bool isHeader = false,
    Color? textColor,
    FontWeight? fontWeight,
  }) {
    final style = GoogleFonts.roboto(
      color: textColor ?? (isHeader ? Colors.grey[800] : Colors.black87),
      fontWeight:
          fontWeight ?? (isHeader ? FontWeight.bold : FontWeight.normal),
      fontSize: 14,
    );

    final widget = Text(text, style: style);

    if (width != null) return SizedBox(width: width, child: widget);
    return Expanded(flex: flex ?? 1, child: widget);
  }
}
