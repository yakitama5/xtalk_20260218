import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xtalk_20260218/config/theme.dart';

class SummarySlide extends FlutterDeckSlideWidget {
  const SummarySlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/summary',
          title: 'Summary',
          steps: 4,
          header: FlutterDeckHeaderConfiguration(title: 'Takeaway'),
          speakerNotes: '''
最後にまとめです。

コードを書く前に「なぜ？」と考えることは大事です。
デザインツール上の絵が全てではなく、その裏にある要求を理解することが重要です。

また、違和感は会話のチャンスなので、すぐに会話しましょう。
結末が変わらなかったとしても、その過程で理解が深まり、より良いシステムになります。

「作らない勇気」を持つことが、システムと私たちの残業時間を守ります。

ご清聴ありがとうございました。
''',
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) {
        return Center(
          child: FlutterDeckSlideStepsBuilder(
            builder: (context, stepNumber) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAnimatedOpacity(
                    stepNumber: stepNumber,
                    showAtStep: 1,
                    child: Text(
                      "Before Coding,\nAsk 'Why?'",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSansJp(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        color: PresentationTheme.primaryColor,
                      ),
                    ),
                  ),
                  const Gap(64),
                  _buildBullet(stepNumber, 2, "Figma != 仕様"),
                  const Gap(24),
                  _buildBullet(stepNumber, 3, "違和感 = 会話のチャンス"),
                  const Gap(24),
                  _buildBullet(
                    stepNumber,
                    4,
                    "「作らない勇気」がシステムと私たちの残業時間を守ります",
                    isStrong: true,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBullet(
    int currentStep,
    int stepIndex,
    String text, {
    bool isStrong = false,
  }) {
    return _buildAnimatedOpacity(
      stepNumber: currentStep,
      showAtStep: stepIndex,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: isStrong
                ? PresentationTheme.successColor
                : PresentationTheme.secondaryTextColor,
            size: 32,
          ),
          const Gap(16),
          Text(
            text,
            style: GoogleFonts.notoSansJp(
              fontSize: 32,
              fontWeight: isStrong ? FontWeight.bold : FontWeight.w500,
              color: isStrong
                  ? PresentationTheme.successColor
                  : PresentationTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedOpacity({
    required int stepNumber,
    required int showAtStep,
    required Widget child,
  }) {
    final isVisible = stepNumber >= showAtStep;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isVisible ? 1.0 : 0.0,
      curve: Curves.easeOut,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 500),
        offset: isVisible ? Offset.zero : const Offset(0, 0.2),
        curve: Curves.easeOutCubic,
        child: child,
      ),
    );
  }
}
