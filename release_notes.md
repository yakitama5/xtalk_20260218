# リリースノート

## v1.0.0 (Initial Release)

XTalk20260218向けLTプレゼンテーションアプリの初期実装が完了しました。

### ✨ 新機能

- **プレゼンテーション基盤**: `flutter_deck` パッケージを使用したスライドショー機能。
- **ダークテーマ**: エンジニア向けLTに適したダークモードデザイン。
- **スライド構成**: 全6枚のスライドを実装。
  1. Title: インパクトのあるタイトル画面
  2. Problem: Figmaモックアップを用いたUI仕様の問題提起
  3. Technology: 技術的なボトルネックの図解
  4. Cost: 実装パターンのコスト比較
  5. Solution (Chat): コミュニケーションによる解決デモ
  6. Summary: "Before Coding, Ask 'Why?'"
- **アニメーション**:
  - ステップ実行による箇条書きの順次表示
  - チャットデモのインタラクティブな進行
  - スタンプのバウンスアニメーション

### 🛠 技術仕様

- **Framework**: Flutter
- **Package**: flutter_deck
- **Fonts**: Google Fonts (Noto Sans JP, Roboto, Black Ops One)
- **Architecture**: Widgetベースのコンポーネント指向設計
