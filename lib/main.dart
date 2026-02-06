import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_web_client/flutter_deck_web_client.dart';
import 'package:xtalk_20260218/config/theme.dart';
import 'package:xtalk_20260218/slides/cost_estimation_slide.dart';
import 'package:xtalk_20260218/slides/interactive_chat_slide.dart';
import 'package:xtalk_20260218/slides/intro_slide.dart';
import 'package:xtalk_20260218/slides/problem_slide.dart';
import 'package:xtalk_20260218/slides/summary_slide.dart';
import 'package:xtalk_20260218/slides/technical_flow_slide.dart';
import 'package:xtalk_20260218/slides/title_slide.dart';

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      isPresenterView: true,
      client: FlutterDeckWebClient(),
      configuration: const FlutterDeckConfiguration(
        background: FlutterDeckBackgroundConfiguration(
          light: FlutterDeckBackground.solid(PresentationTheme.backgroundColor),
          dark: FlutterDeckBackground.solid(PresentationTheme.backgroundColor),
        ),
        footer: FlutterDeckFooterConfiguration(
          showSlideNumbers: true,
          showSocialHandle: true,
          showFooter: true,
        ),
        showProgress: false,
      ),
      slides: const [
        TitleSlide(),
        IntroSlide(),
        ProblemSlide(),
        TechnicalFlowSlide(),
        CostEstimationSlide(),
        InteractiveChatSlide(),
        SummarySlide(),
      ],
      lightTheme: PresentationTheme.darkTheme,
      darkTheme: PresentationTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
