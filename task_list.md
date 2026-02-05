# タスクリスト

## 実装計画に基づくタスク状況

- [x] **1. プロジェクト基盤の設定**
  - [x] pubspec.yamlにflutter_deckパッケージを追加
  - [x] プロジェクト構造（lib/slides/, lib/widgets/）を作成
  - [x] ダークテーマ設定とカラーパレット定義 (`lib/config/theme.dart`)

- [x] **2. メインアプリケーションとテーマ設定の実装**
  - [x] PresentationAppクラスの実装 (`lib/main.dart`)
  - [x] FlutterDeckAppの設定とダークテーマ適用

- [x] **3. タイトルスライドの実装**
  - [x] TitleSlideクラスの実装 (`lib/slides/title_slide.dart`)
    - タイトル、サブタイトル、背景装飾の実装

- [x] **4. 問題提起スライドの実装**
  - [x] FigmaMockupWidgetの実装 (`lib/widgets/figma_mockup_widget.dart`)
  - [x] ProblemSlideクラスの実装 (`lib/slides/problem_slide.dart`)

- [x] **5. 技術的課題フロー図の実装**
  - [x] ProcessFlowWidgetの実装 (`lib/widgets/process_flow_widget.dart`)
  - [x] TechnicalFlowSlideクラスの実装 (`lib/slides/technical_flow_slide.dart`)

- [x] **6. コスト見積もりスライドの実装**
  - [x] CostCardWidgetの実装 (`lib/widgets/cost_card_widget.dart`)
  - [x] CostEstimationSlideクラスの実装 (`lib/slides/cost_estimation_slide.dart`)

- [x] **8. インタラクティブチャット機能の実装**
  - [x] ChatBubbleWidgetの実装 (`lib/widgets/chat_bubble_widget.dart`)
  - [x] AnimatedStampWidgetの実装 (`lib/widgets/animated_stamp_widget.dart`)
  - [x] InteractiveChatSlideクラスの実装 (`lib/slides/interactive_chat_slide.dart`)

- [x] **9. まとめスライドの実装**
  - [x] SummarySlideクラスの実装 (`lib/slides/summary_slide.dart`)

- [x] **10. アニメーション効果の実装**
  - [x] `flutter_deck` のステップ機能や `AnimatedOpacity` を使用して実装済み

- [x] **11. 統合**
  - [x] 全スライドの `main.dart` への統合
