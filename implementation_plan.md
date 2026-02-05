# 実装計画: Flutter Presentation (XTalk20260218)

この計画書は、`flutter_deck` パッケージを使用したエンジニアリングLT用プレゼンテーションの実装手順を定義します。

## プロジェクト概要

- **プロジェクト名**: xtalk_20260218
- **目的**: "不要な機能実装のコスト"に関するLT資料の作成
- **技術スタック**: Flutter, flutter_deck
- **ディレクトリ**: ルートディレクトリを使用（単一プロジェクト構成として扱う）

## フェーズ 1: 環境セットアップと基盤構築

このフェーズでは、必要なパッケージの導入と、アプリの骨格、全体のテーマ設定を行います。

- [ ] **1.1 パッケージの追加**
  - `flutter_deck`: プレゼンテーション機能
  - `google_fonts`: カスタムフォント
  - `flutter_riverpod`: 必要に応じて状態管理（今回はStatefulWidgetで十分な可能性が高いが、拡張性を考慮）
  - `gap`: レイアウト調整用
  - コマンド: `flutter pub add flutter_deck google_fonts gap`

- [ ] **1.2 ディレクトリ構造の整理**
  - `lib/slides/`: 各スライドファイル
  - `lib/widgets/`: 再利用可能なカスタムウィジェット
  - `lib/config/`: テーマや定数設定
  - `lib/models/`: データモデル（チャットデータなど）

- [ ] **1.3 テーマ設定の実装**
  - ファイル: `lib/config/theme.dart`
  - 内容:
    - ダークテーマの定義（背景色: #121212）
    - カラーパレットの定義（Primary: Deep Blue, Warning: Red/Orange, Success: Green）
    - テキストスタイルの定義（Google Fonts使用）

- [ ] **1.4 メインアプリケーションの実装**
  - ファイル: `lib/main.dart`
  - 内容: `FlutterDeckApp` の初期化、テーマの適用、空のスライドリストの設定

## フェーズ 2: コンポーネントとスライドの実装 (前半)

前半のスライド（タイトル、問題提起、技術調査）を実装します。

- [ ] **2.1 タイトルスライドの実装**
  - ファイル: `lib/slides/title_slide.dart`
  - 内容: タイトル、サブタイトル、発表者名、背景装飾（大きな矢印アイコン）

- [ ] **2.2 FigmaMockupウィジェットの実装**
  - ファイル: `lib/widgets/figma_mockup_widget.dart`
  - 内容: UIデザインツール風のテーブル表示、ページネーション、ハイライト機能

- [ ] **2.3 問題提起スライドの実装**
  - ファイル: `lib/slides/problem_slide.dart`
  - 内容: 左右分割レイアウトで `FigmaMockupWidget` と説明テキストを表示

- [ ] **2.4 ProcessFlowウィジェットの実装**
  - ファイル: `lib/widgets/process_flow_widget.dart`
  - 内容: データベースアイコン、カード、矢印を使ったフロー図の描画

- [ ] **2.5 技術的課題スライドの実装**
  - ファイル: `lib/slides/technical_flow_slide.dart`
  - 内容: `ProcessFlowWidget` を使用して "全件フェッチ & 高負荷" の流れを図解

## フェーズ 3: コンポーネントとスライドの実装 (後半)

後半のスライド（コスト比較、チャットデモ、まとめ）を実装します。

- [ ] **3.1 コストカードウィジェットの実装**
  - ファイル: `lib/widgets/cost_card_widget.dart`
  - 内容: プラン名、価格、アイコンを表示するカード

- [ ] **3.2 コスト見積もりスライドの実装**
  - ファイル: `lib/slides/cost_estimation_slide.dart`
  - 内容: 3カラムレイアウトで Plan A, B, C を比較表示

- [ ] **3.3 チャット関連ウィジェットの実装**
  - ファイル: `lib/widgets/chat_bubble_widget.dart`, `lib/widgets/animated_stamp_widget.dart`
  - 内容: メッセージバブルとアニメーション付きスタンプ

- [ ] **3.4 インタラクティブチャットスライドの実装**
  - ファイル: `lib/slides/interactive_chat_slide.dart`
  - 内容: `StatefulWidget` を使用したチャットデモ。ボタンクリックで会話が進むロジック。

- [ ] **3.5 まとめスライドの実装**
  - ファイル: `lib/slides/summary_slide.dart`
  - 内容: "Before Coding, Ask 'Why?'" を中心としたメッセージ表示

- [ ] **3.6 スライドの統合**
  - `main.dart` の `slides` リストに作成した全スライドを追加

## フェーズ 4: アニメーションとテスト、仕上げ

各スライドのリファインとテストを行います。

- [ ] **4.1 アニメーションの適用**
  - `flutter_deck` のアニメーション機能またはFlutter標準のアニメーションを使用して、各要素のフェードイン/スライドインを実装（要件9参照）

- [ ] **4.2 テストの実装**
  - 各スライドのウィジェットテスト（表示確認）
  - インタラクティブ機能（チャット）のロジックテスト

- [ ] **4.3 最終確認**
  - `flutter_lints` によるコード分析と修正
  - デザイン要件との整合性チェック
