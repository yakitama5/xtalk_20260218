# 考察ログ - InteractiveChatSlide のリファクタリング

## 現状の分析

- `lib/slides/interactive_chat_slide.dart` が `StatefulWidget` を直接継承しており、`FlutterDeck` のタイトルやヘッダーが正しく設定されていない。
- スライド内で「スタンプを表示する」という状態管理（`_showStamp`）が必要。

## 解決策の検討

1. `InteractiveChatSlide` を `FlutterDeckSlideWidget` に変更する。
2. スライドの構成（`FlutterDeckSlideConfiguration`）をコンストラクタで定義し、タイトルやヘッダーを有効にする。
3. `FlutterDeckSlideWidget.build` メソッド内で `FlutterDeckSlide.custom` を使用する。
4. 状態管理が必要なメインコンテンツ部分を `_InteractiveChatContent`（`StatefulWidget`）として分離し、カプセル化する。

## 実装のポイント

- `FlutterDeckSlideWidget` はイミュータブルであるべきなので、状態を持つ箇所を別ウィジェットに切り出すのがベストプラクティス。
- `InteractiveChatDemo`（チャットのシミュレーター）は既存のまま利用し、完了時のコールバックでスタンプを表示させる。
