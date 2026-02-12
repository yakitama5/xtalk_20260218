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
          speakerNotes: '''
なぜこの機能が難しいのか、技術的な裏側を説明します。

このシステムではStatus列に表示している内容を、他テーブルを参照してバックエンドの業務ロジックで算出しています。
そのため、愚直に行うとDBのインデックスが使えず、ソートのためだけに毎回、全件走査と計算が発生してしまいます。
''',
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
