import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:gap/gap.dart';
import 'package:xtalk_20260218/config/theme.dart';
import 'package:xtalk_20260218/widgets/cost_card_widget.dart';

class CostEstimationSlide extends FlutterDeckSlideWidget {
  const CostEstimationSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/cost-estimation',
          title: 'Cost Estimation',
          steps: 3,
          header: FlutterDeckHeaderConfiguration(title: '実装オプションとコスト'),
          speakerNotes: '''
根性でどうにかするのは現実的ではないので、いくつかのプランが浮かび上がります。

登録時の計算結果を物理カラムに保存する？既存データはバッチで？
あるいは検索エンジンの導入？

しかし、たかがソート機能一つのために、どれも初期構築や保守に数十万〜百万円単位の大きなコストがかかります。
''',
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
          child: FlutterDeckSlideStepsBuilder(
            builder: (context, stepNumber) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildAnimatedCard(
                      stepNumber: stepNumber,
                      showAtStep: 1,
                      child: const CostCardWidget(
                        title: 'Plan A\n(Force)',
                        subTitle: '全件取得＆メモリ計算',
                        price: 'Priceless',
                        icon: Icons.dangerous,
                        color: PresentationTheme.warningColor,
                      ),
                    ),
                  ),
                  const Gap(32),
                  Expanded(
                    child: _buildAnimatedCard(
                      stepNumber: stepNumber,
                      showAtStep: 2,
                      child: const CostCardWidget(
                        title: 'Plan B\n(Batch)',
                        subTitle: '夜間バッチ＆専用テーブル',
                        price: '50万円~',
                        icon: Icons.build,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  const Gap(32),
                  Expanded(
                    child: _buildAnimatedCard(
                      stepNumber: stepNumber,
                      showAtStep: 3,
                      child: const CostCardWidget(
                        title: 'Plan C\n(Search Engine)',
                        subTitle: 'OpenSearch/ElasticSearch導入',
                        price: '100万円~',
                        icon: Icons.cloud_upload,
                        color: Colors.blueAccent, // 黄色だと背景で見にくいので青アクセントに変更
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAnimatedCard({
    required int stepNumber,
    required int showAtStep,
    required Widget child,
  }) {
    final isVisible = stepNumber >= showAtStep;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isVisible ? 1.0 : 0.0, // 0.2位にしておくと存在がわかって良いかもだが、非表示要件なので0
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 500),
        offset: isVisible ? Offset.zero : const Offset(0, 0.1),
        curve: Curves.easeOutCubic,
        child: child,
      ),
    );
  }
}
