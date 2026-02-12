# 実装計画 - InteractiveChatSlide のリファクタリング

## 概要

`InteractiveChatSlide` を `FlutterDeckSlideWidget` を継承するように変更し、スライドのタイトルやヘッダーが表示されるようにします。また、状態管理を適切に分離します。

## 変更内容

1. `InteractiveChatSlide` の変更
   - `StatefulWidget` -> `FlutterDeckSlideWidget` への継承変更。
   - `configuration` の定義。
   - `build` メソッドで `_InteractiveChatContent` を呼び出すように変更。
2. `_InteractiveChatContent` の作成
   - 既存の `InteractiveChatSlide` が持っていた状態（`_showStamp`）と UI ロジックをここに移動。
3. `InteractiveChatDemo` との連携
   - 完了時の `onSequenceComplete` コールバックを `_InteractiveChatContent` で受け取り、スタンプを表示。

## 完了条件

- [x] `FlutterDeckSlideWidget` を継承していること。
- [x] スライド設定（タイトル、ヘッダー、スピーカーノート）が反映されること。
- [x] チャットシーケンス完了後にスタンプが表示されること。
