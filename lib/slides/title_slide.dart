import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xtalk_20260218/config/theme.dart';

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/title',
          title: 'Title',
          footer: FlutterDeckFooterConfiguration(showSlideNumbers: false),
          speakerNotes: '''
皆さんこんにちは。

本日は「その矢印アイコン、実装コストは100万円です」というタイトルでお話しします。

実体験を少しオーバーにしているので、一部フィクションだと思ってエンタメとして聞いていただければと思います。
''',
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Stack(
          children: [
            // 背景装飾（要件2.4）
            Positioned(
              right: -200,
              bottom: -200,
              child: Opacity(
                opacity: 0.1,
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 1000,
                  color: PresentationTheme.textColor,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 要件2.1
                    Text(
                      'その矢印アイコン、\n実装コストは100万円です',
                      style: GoogleFonts.kiwiMaru(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        color: PresentationTheme.textColor,
                      ),
                    ),
                    const Gap(32),
                    // 要件2.2
                    Text(
                      'ユーザーニーズのない機能に全力投球しないために',
                      style: GoogleFonts.kiwiMaru(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: PresentationTheme.secondaryTextColor,
                      ),
                    ),
                    const Gap(64),
                    // 要件2.3
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: PresentationTheme.primaryColor.withValues(
                          alpha: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: PresentationTheme.primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.person,
                            color: PresentationTheme.primaryDarkColor,
                          ),
                          const Gap(12),
                          Text(
                            'やくらん',
                            style: GoogleFonts.kiwiMaru(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: PresentationTheme.primaryDarkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
