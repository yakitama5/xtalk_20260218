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
          steps: 3, // アニメーションステップを3に変更
          speakerNotes: '''
まずこちらをご覧下さい。

(Goto2)
こちらの画面は顧客から提供されたFigmaのデザインです。
よくある一覧系の管理画面ですね。

しかし、この画面を確認すると、ある懸念が浮かび上がります。

(Goto3)
それが、この「Statusのソート」と「ページネーション」の組み合わせです。
''',
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return FlutterDeckSlideStepsBuilder(
          builder: (context, stepNumber) {
            // ステップごとの状態
            final isZoomed = stepNumber == 1;
            final showSplit = stepNumber >= 2;
            final showProblems = stepNumber >= 3;

            return Stack(
              children: [
                // 背景 (左右分割のガイドライン的なもの)
                if (showSplit)
                  Row(
                    children: [
                      Expanded(flex: 5, child: Container()),
                      const VerticalDivider(
                        color: PresentationTheme.secondaryTextColor,
                        width: 1,
                      ),
                      Expanded(flex: 4, child: Container()),
                    ],
                  ),

                // 左側: Figma Mockup (ズームアニメーション付き)
                AnimatedAlign(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOutCubic,
                  alignment: isZoomed
                      ? Alignment.center
                      : const Alignment(-0.8, 0),
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOutCubic,
                    scale: isZoomed ? 1.4 : 1.0,
                    child: SizedBox(
                      width: 600,
                      height: 500,
                      child: const FigmaMockupWidget(),
                    ),
                  ),
                ),

                // 右側: 問題提示
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: MediaQuery.of(context).size.width * 0.44, // flex 4相当
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: showSplit ? 1.0 : 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'よくあるUI仕様',
                            style: GoogleFonts.kiwiMaru(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: PresentationTheme.primaryDarkColor,
                            ),
                          ),
                          const Gap(32),
                          _buildPoint(
                            context,
                            '「一覧画面、デフォルトでStatus順ね」',
                            isVisible: showSplit,
                          ),
                          const Gap(20),
                          _buildPoint(
                            context,
                            '「ページネーションも必須で」',
                            isVisible: showSplit,
                          ),
                          const Gap(48),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: showProblems ? 1.0 : 0.0,
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: PresentationTheme.warningColor
                                    .withValues(alpha: 0.2),
                                border: const Border(
                                  left: BorderSide(
                                    color: PresentationTheme.warningDarkColor,
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
                                        color:
                                            PresentationTheme.warningDarkColor,
                                      ),
                                      const Gap(12),
                                      Text(
                                        '隠されたコスト',
                                        style: GoogleFonts.kiwiMaru(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: PresentationTheme
                                              .warningDarkColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(16),
                                  Text(
                                    'Statusは計算フィールド...\nDBインデックスが効かない！？',
                                    style: GoogleFonts.kiwiMaru(
                                      fontSize: 20,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPoint(
    BuildContext context,
    String text, {
    required bool isVisible,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isVisible ? 1.0 : 0.0,
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
            child: Text(text, style: GoogleFonts.kiwiMaru(fontSize: 24)),
          ),
        ],
      ),
    );
  }
}
