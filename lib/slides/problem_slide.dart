import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xtalk_20260218/config/theme.dart';
import 'package:xtalk_20260218/widgets/figma_mockup_widget.dart';

class ProblemSlide extends FlutterDeckSlideWidget {
  const ProblemSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/problem',
          title: 'Problem',
          steps: 2, // アニメーションステップ
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      splitRatio: SplitSlideRatio(left: 5, right: 4),
      leftBuilder: (context) {
        return FlutterDeckSlideStepsBuilder(
          builder: (context, stepNumber) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: stepNumber >= 1 ? 1.0 : 0.0,
              child: const Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: SizedBox(height: 500, child: FigmaMockupWidget()),
                ),
              ),
            );
          },
        );
      },
      rightBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'よくあるUI仕様',
                style: GoogleFonts.notoSansJp(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: PresentationTheme.primaryColor,
                ),
              ),
              const Gap(24),
              _buildBulletPoint(context, '「一覧画面、デフォルトでStatus順ね」', delay: 1),
              const Gap(16),
              _buildBulletPoint(context, '「ページネーションも必須で」', delay: 1),
              const Gap(48),
              FlutterDeckSlideStepsBuilder(
                builder: (context, stepNumber) {
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: stepNumber >= 2 ? 1.0 : 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: PresentationTheme.warningColor.withValues(
                          alpha: 0.1,
                        ),
                        border: Border(
                          left: BorderSide(
                            color: PresentationTheme.warningColor,
                            width: 4,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.warning_amber,
                                color: PresentationTheme.warningColor,
                              ),
                              const Gap(12),
                              Text(
                                '隠されたコスト',
                                style: GoogleFonts.notoSansJp(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: PresentationTheme.warningColor,
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          Text(
                            'Statusは計算フィールド...\nDBインデックスが効かない！？',
                            style: GoogleFonts.notoSansJp(
                              fontSize: 20,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBulletPoint(
    BuildContext context,
    String text, {
    required int delay,
  }) {
    return FlutterDeckSlideStepsBuilder(
      builder: (context, stepNumber) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: stepNumber >= delay ? 1.0 : 0.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.arrow_right,
                  color: PresentationTheme.secondaryTextColor,
                ),
              ),
              const Gap(8),
              Expanded(
                child: Text(text, style: GoogleFonts.notoSansJp(fontSize: 24)),
              ),
            ],
          ),
        );
      },
    );
  }
}
