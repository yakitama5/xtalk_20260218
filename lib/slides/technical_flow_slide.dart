import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:xtalk_20260218/widgets/process_flow_widget.dart';

class TechnicalFlowSlide extends FlutterDeckSlideWidget {
  const TechnicalFlowSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/technical-flow',
          title: 'Technical Flow',
          header: FlutterDeckHeaderConfiguration(title: '技術的な裏側'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(32.0),
          child: ProcessFlowWidget(),
        );
      },
    );
  }
}
