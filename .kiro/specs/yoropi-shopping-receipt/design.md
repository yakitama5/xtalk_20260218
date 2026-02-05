# 設計書

## 概要

Yoropic（ヨロピック）は、買い物リストをポップなレシート風画像に変換してシェアするFlutterアプリです。シンプルな1画面完結型のUXで、テキスト入力からレシート生成、画像シェアまでを直感的に行えます。

## アーキテクチャ

### 全体アーキテクチャ

```
┌─────────────────────────────────────────┐
│              Presentation Layer          │
│  ┌─────────────────┐ ┌─────────────────┐ │
│  │   Input Screen  │ │ Preview Screen  │ │
│  │                 │ │                 │ │
│  │ - TextField     │ │ - Receipt Card  │ │
│  │ - Preview Btn   │ │ - Share Btn     │ │
│  └─────────────────┘ └─────────────────┘ │
└─────────────────────────────────────────┘
                    │
┌─────────────────────────────────────────┐
│            Application Layer             │
│  ┌─────────────────┐ ┌─────────────────┐ │
│  │ Input Notifier  │ │Receipt Service  │ │
│  │                 │ │                 │ │
│  │ - Text State    │ │ - Image Gen     │ │
│  │ - Mode State    │ │ - Share Logic   │ │
│  └─────────────────┘ └─────────────────┘ │
└─────────────────────────────────────────┘
                    │
┌─────────────────────────────────────────┐
│               Core Layer                 │
│  ┌─────────────────┐ ┌─────────────────┐ │
│  │  Theme Manager  │ │   Utilities     │ │
│  │                 │ │                 │ │
│  │ - M3 Themes     │ │ - Image Utils   │ │
│  │ - Dark Mode     │ │ - Text Utils    │ │
│  └─────────────────┘ └─────────────────┘ │
└─────────────────────────────────────────┘
```

### 状態管理アーキテクチャ

Flutter Riverpodを使用したリアクティブな状態管理：

```
AppState
├── inputText: String
├── currentMode: AppMode (input | preview)
├── isLoading: bool
└── errorMessage: String?

AppMode
├── Input: テキスト入力モード
└── Preview: レシートプレビューモード
```

## コンポーネントとインターフェース

### 1. Input Manager

テキスト入力の状態管理を担当するコンポーネント。

```dart
class InputNotifier extends StateNotifier<InputState> {
  // テキスト更新
  void updateText(String text);
  
  // 入力検証
  bool isValidInput(String text);
  
  // テキストクリア
  void clearText();
}

class InputState {
  final String text;
  final bool isValid;
  final List<String> items;
}
```

### 2. UI Controller

画面モードの切り替えを管理するコンポーネント。

```dart
class AppModeNotifier extends StateNotifier<AppMode> {
  // プレビューモードに切り替え
  void switchToPreview();
  
  // 入力モードに戻る
  void switchToInput();
  
  // 現在のモード取得
  AppMode getCurrentMode();
}

enum AppMode { input, preview }
```

### 3. Receipt Generator

レシート風デザインの生成を担当するコンポーネント。

```dart
class ReceiptCard extends ConsumerWidget {
  final List<String> items;
  final bool isDarkMode;
  
  Widget build(BuildContext context, WidgetRef ref);
}

class ReceiptClipper extends CustomClipper<Path> {
  // ギザギザ形状の生成
  Path getClip(Size size);
}
```

### 4. Share Service

画像生成とシェア機能を担当するサービス。

```dart
class ReceiptService {
  // Widget to Image変換
  Future<Uint8List> captureReceiptAsImage(GlobalKey key);
  
  // 画像シェア
  Future<void> shareReceiptImage(Uint8List imageData);
  
  // エラーハンドリング
  void handleShareError(Object error);
}
```

### 6. Haptic Manager

ハプティクスフィードバックを管理するコンポーネント。

```dart
class HapticManager {
  // 軽いハプティクス（ボタンタップ）
  static void lightImpact();
  
  // 中程度のハプティクス（重要なアクション）
  static void mediumImpact();
  
  // 成功通知ハプティクス
  static void successNotification();
  
  // エラー通知ハプティクス
  static void errorNotification();
  
  // ハプティクス対応チェック
  static bool isHapticsSupported();
}
```

### 7. Theme Manager

テーマとダークモード対応を管理するコンポーネント。

```dart
class ThemeManager {
  // ライトテーマ
  static ThemeData lightTheme();
  
  // ダークテーマ
  static ThemeData darkTheme();
  
  // ピンク色パレット
  static ColorScheme pinkColorScheme(bool isDark);
}
```

```dart
class HapticManager {
  // 軽いハプティクス（ボタンタップ）
  static void lightImpact();
  
  // 中程度のハプティクス（重要なアクション）
  static void mediumImpact();
  
  // 成功通知ハプティクス
  static void successNotification();
  
  // エラー通知ハプティクス
  static void errorNotification();
  
  // ハプティクス対応チェック
  static bool isHapticsSupported();
}
```

テーマとダークモード対応を管理するコンポーネント。

```dart
class ThemeManager {
  // ライトテーマ
  static ThemeData lightTheme();
  
  // ダークテーマ
  static ThemeData darkTheme();
  
  // ピンク色パレット
  static ColorScheme pinkColorScheme(bool isDark);
}
```

## データモデル

### ReceiptData

レシート生成に必要なデータを格納するモデル。

```dart
class ReceiptData {
  final List<String> items;
  final DateTime timestamp;
  final String headerText;
  final int totalItems;
  
  ReceiptData({
    required this.items,
    required this.timestamp,
    this.headerText = 'YOROPIC MART',
    required this.totalItems,
  });
  
  // JSON変換（将来的な拡張用）
  Map<String, dynamic> toJson();
  factory ReceiptData.fromJson(Map<String, dynamic> json);
}
```

### AppConfiguration

アプリの設定情報を管理するモデル。

```dart
class AppConfiguration {
  final double imagePixelRatio;
  final String defaultFont;
  final Color primaryColor;
  final bool enableDarkMode;
  
  static const AppConfiguration defaultConfig = AppConfiguration(
    imagePixelRatio: 3.0,
    defaultFont: 'Mochiy Pop One',
    primaryColor: Color(0xFFFF4081),
    enableDarkMode: true,
  );
}
```

## 正確性プロパティ

プロパティとは、システムのすべての有効な実行において真であるべき特性や動作のことです。プロパティは、人間が読める仕様と機械で検証可能な正確性保証の橋渡しとなる、システムが何をすべきかについての形式的な記述です。

### プロパティ 1: テキスト分割の一貫性

*任意の* 改行を含むテキスト入力に対して、Input_Managerで分割されたアイテム数は、元のテキストの非空行数と等しくなければならない
**検証対象: 要件 1.2**

### プロパティ 2: 外部テキスト処理の堅牢性

*任意の* 外部からコピーされたテキストに対して、Input_Managerは例外を発生させることなく処理を完了しなければならない
**検証対象: 要件 1.3**

### プロパティ 3: ボタン状態の論理的一貫性

*任意の* 非空文字列入力に対して、プレビューボタンは有効状態でなければならない
**検証対象: 要件 1.5**

### プロパティ 4: レシート生成の完全性

*任意の* 有効なテキスト入力に対して、Receipt_Generatorは対応するレシートWidgetを生成しなければならない
**検証対象: 要件 2.1**

### プロパティ 5: レシート要素の包含性

*任意の* 生成されたレシートに対して、ヘッダー、ボディ、フッターのすべての必須要素が含まれていなければならない
**検証対象: 要件 2.2, 2.3, 2.4**

### プロパティ 6: ギザギザ形状の適用

*任意の* 生成されたレシートWidgetに対して、CustomClipperによるギザギザ形状が適用されていなければならない
**検証対象: 要件 2.5**

### プロパティ 7: 色設定の正確性

*任意の* 生成されたレシートに対して、指定されたピンク色（#FFFF4081）が基調色として使用されていなければならない
**検証対象: 要件 2.6**

### プロパティ 8: 状態遷移の双方向性

*任意の* アプリ状態に対して、入力モード→プレビューモード→入力モードの遷移を行った後、元の入力テキストが保持されていなければならない
**検証対象: 要件 3.2, 3.4**

### プロパティ 9: UI状態の一貫性

*任意の* モード切り替えに対して、UI_Controllerは対応するUI要素の表示/非表示状態を正しく管理しなければならない
**検証対象: 要件 3.3, 3.5**

### プロパティ 10: 画像変換の成功性

*任意の* 有効なレシートWidgetに対して、Share_Serviceは対応するPNG画像データを生成しなければならない
**検証対象: 要件 4.1**

### プロパティ 11: 画像品質の保証

*任意の* 生成された画像に対して、pixelRatioは3.0以上でなければならない
**検証対象: 要件 4.3**

### プロパティ 12: エラー処理の安全性

*任意の* 画像変換エラーに対して、Share_Serviceはアプリクラッシュを発生させることなく適切なエラーメッセージを表示しなければならない
**検証対象: 要件 4.4**

### プロパティ 13: テーマ適用の正確性

*任意の* システムテーマ設定に対して、Theme_Managerは対応する色設定を適用しなければならない
**検証対象: 要件 5.2, 5.3, 5.4**

### プロパティ 14: テーマ連動の一貫性

*任意の* テーマ変更に対して、アプリUI とレシート画像の両方が同じテーマ設定を反映しなければならない
**検証対象: 要件 5.5**

### プロパティ 15: 長文レイアウトの適応性

*任意の* 長いアイテム名に対して、Receipt_Generatorはレイアウト崩れを起こすことなく表示しなければならない
**検証対象: 要件 6.1**

### プロパティ 16: 動的高さ調整

*任意の* アイテム数に対して、Receipt_Generatorは適切なレシート高さを計算しなければならない
**検証対象: 要件 6.2**

### プロパティ 17: 空行フィルタリング

*任意の* 空行を含むテキスト入力に対して、Receipt_Generatorは空行を除外した有効なアイテムのみを表示しなければならない
**検証対象: 要件 6.3**

### プロパティ 18: 特殊文字処理の堅牢性

*任意の* 特殊文字を含むテキストに対して、Receipt_Generatorは文字化けや表示エラーを起こすことなく処理しなければならない
**検証対象: 要件 6.4**

### プロパティ 19: 多言語フォント適用

*任意の* 日本語と英語が混在するテキストに対して、Receipt_Generatorは両方の言語を適切なフォントで表示しなければならない
**検証対象: 要件 6.5**

### プロパティ 20: メモリエラー処理

*任意の* メモリ不足状態に対して、Systemは適切なエラーハンドリングを行い、アプリの安定性を維持しなければならない
**検証対象: 要件 8.4**

### プロパティ 21: オフライン機能の保証

*任意の* ネットワーク接続状態に対して、Systemは基本機能（テキスト入力、レシート生成、画像変換）を提供しなければならない
**検証対象: 要件 8.5**

### プロパティ 22: ハプティクス実行の確実性

*任意の* 対応するユーザーアクションに対して、Haptic_Managerは適切なハプティクスフィードバックを実行しなければならない
**検証対象: 要件 7.1, 7.2, 7.3, 7.4, 7.5**

### プロパティ 23: ハプティクス非対応端末の安全性

*任意の* ハプティクス非対応端末に対して、Systemはハプティクス機能なしで正常に動作を継続しなければならない
**検証対象: 要件 7.6**

## エラーハンドリング

### 入力エラー処理

- **空入力**: プレビューボタンを無効化し、ユーザーに入力を促すメッセージを表示
- **不正文字**: 特殊文字や絵文字を含む入力でも適切に処理し、表示可能な形式に変換
- **過度に長い入力**: 文字数制限を設け、超過時は警告メッセージを表示

### 画像生成エラー処理

- **メモリ不足**: 画像生成時のメモリ不足を検出し、低解像度での再試行を実行
- **Widget変換失敗**: RepaintBoundaryの取得に失敗した場合、エラーメッセージを表示してプレビューモードを維持
- **ファイル保存失敗**: 一時ファイルの作成に失敗した場合、代替の保存方法を試行

### システムエラー処理

- **テーマ読み込み失敗**: システムテーマの取得に失敗した場合、デフォルトのライトテーマを適用
- **フォント読み込み失敗**: カスタムフォントの読み込みに失敗した場合、システムデフォルトフォントにフォールバック
- **シェア機能エラー**: OS標準シェアシートの起動に失敗した場合、クリップボードへのコピー機能を提供

## テスト戦略

### 二重テストアプローチ

- **単体テスト**: 特定の例、エッジケース、エラー条件を検証
- **プロパティテスト**: すべての入力にわたる汎用的なプロパティを検証
- 両方のテストは相補的であり、包括的なカバレッジに必要

### 単体テストのバランス

単体テストは特定の例やエッジケースに焦点を当て、プロパティベーステストは多くの入力をカバーします：

**単体テストの焦点**:

- 特定の例（空文字列、日本語テキスト、長文など）
- コンポーネント間の統合ポイント
- エッジケースとエラー条件（メモリ不足、ネットワークエラーなど）

**プロパティテストの焦点**:

- すべての入力にわたって保持される汎用的なプロパティ
- ランダム化による包括的な入力カバレッジ

### プロパティベーステスト設定

- **テストライブラリ**: `fake` パッケージを使用してランダムデータ生成
- **最小反復回数**: プロパティテストごとに100回の反復を実行
- **各プロパティテストの参照**: 設計書のプロパティを参照するタグを含める
- **タグ形式**: **Feature: yoropic-shopping-receipt, Property {number}: {property_text}**
- **実装要件**: 各正確性プロパティは単一のプロパティベーステストで実装される

### テスト対象コンポーネント

1. **Input Manager**: テキスト処理とバリデーション
2. **Receipt Generator**: レシート生成とレイアウト
3. **UI Controller**: 状態管理とモード切り替え
4. **Share Service**: 画像変換とシェア機能
5. **Theme Manager**: テーマ適用とダークモード対応

### 統合テスト

- **エンドツーエンドフロー**: 入力→プレビュー→シェアの完全なユーザージャーニー
- **テーマ切り替え**: ライト/ダークモード間の切り替えテスト
- **エラーリカバリ**: エラー発生後の正常な復旧テスト
