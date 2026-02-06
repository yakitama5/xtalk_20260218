# その矢印アイコン、実装コストは100万円です

XTalk (2026/02/18) での発表資料「その矢印アイコン、実装コストは100万円です」のソースコードです。

## 概要

このプロジェクトは、[flutter_deck](https://pub.dev/packages/flutter_deck) を使用して構築されたインタラクティブなプレゼンテーション資料です。
ユーザーニーズのない機能にリソースを割かないための考え方や、実際のコスト見積もりのシミュレーションなどを、Flutter アプリケーションとして実装しています。

### 発表タイトル

**その矢印アイコン、実装コストは100万円です**  
〜ユーザーニーズのない機能に全力投球しないために〜

## 開発プロセス (バイブコーディング)

本プロジェクトは、AI エージェントをフル活用した「バイブコーディング」によって短期間で構築されました。

1. **Gemini**: コンセプトの壁打ち・構成案の作成
2. **kiro**: 技術選定・詳細仕様 (Spec) の策定
3. **Antigravity**: 実装・意匠の製造 (Development)

## 主なコンテンツ

- **問題提起**: なぜ不要な機能が生まれてしまうのか
- **技術フロー**: 実装に至るまでのプロセス
- **コスト見積もりシミュレーション**: 具体的な金額を提示した視認性の高いスライド
- **インタラクティブチャット**: チャット形式でのシミュレーションと、コスト意識を強調する「Cost ¥0」スタンプなどの演出

## 実行方法

### 事前準備

- Flutter SDK がインストールされていること
- Web ブラウザ（Chrome 等）が利用可能であること

### 起動

以下のコマンドを実行して、プレゼンテーションを Web で起動します。

```bash
flutter run -d chrome
```

## 使用技術

- [Flutter](https://flutter.dev/)
- [flutter_deck](https://pub.dev/packages/flutter_deck): プレゼンテーションフレームワーク
- [google_fonts](https://pub.dev/packages/google_fonts): フォント
- [gap](https://pub.dev/packages/gap): レイアウト調整
- [qr_flutter](https://pub.dev/packages/qr_flutter): QRコード生成

## 著者

やくらん ([@yakitama5](https://github.com/yakitama5))
