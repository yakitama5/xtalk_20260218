# 要件定義書

## はじめに

Yoropic（ヨロピック）は、買い物リストを「ポップなレシート風の発注書」に変換してシェアするモバイルアプリです。テキストチャットで送るだけでは埋もれてしまう「買ってきてほしいもの」を、視認性の高い画像にすることで、買い忘れや未読スルーを防ぎます。

## 用語集

- **System**: Yoropic アプリケーション
- **Receipt_Generator**: レシート風画像を生成するコンポーネント
- **Share_Service**: 画像をシェアするサービス
- **Input_Manager**: テキスト入力を管理するコンポーネント
- **UI_Controller**: 画面モードを制御するコンポーネント
- **Theme_Manager**: テーマとダークモード対応を管理するコンポーネント
- **Haptic_Manager**: ハプティクスフィードバックを管理するコンポーネント

## 要件

### 要件 1: テキスト入力機能

**ユーザーストーリー:** ユーザーとして、買い物リストを簡単にテキストで入力したい。そうすることで、素早く買い物依頼を作成できる。

#### 受け入れ基準

1. WHEN アプリが起動される THEN THE Input_Manager SHALL テキスト入力エリアにフォーカスを設定する
2. WHEN ユーザーがテキストを入力する THEN THE Input_Manager SHALL 改行区切りで複数のアイテムを受け入れる
3. WHEN ユーザーがコピー&ペーストを行う THEN THE Input_Manager SHALL 外部からのテキストを正しく処理する
4. WHEN テキスト入力エリアが空の状態 THEN THE System SHALL プレビューボタンを無効化する
5. WHEN テキスト入力エリアに内容がある状態 THEN THE System SHALL プレビューボタンを有効化する

### 要件 2: レシート風デザイン生成

**ユーザーストーリー:** ユーザーとして、入力したテキストがポップなレシート風の画像に変換されることを期待する。そうすることで、視認性の高い買い物依頼を作成できる。

#### 受け入れ基準

1. WHEN ユーザーがプレビューボタンを押す THEN THE Receipt_Generator SHALL 入力テキストをレシート風デザインに変換する
2. WHEN レシートが生成される THEN THE Receipt_Generator SHALL ヘッダーにアプリロゴと日時を表示する
3. WHEN レシートが生成される THEN THE Receipt_Generator SHALL ボディに入力されたアイテムを中央揃えで表示する
4. WHEN レシートが生成される THEN THE Receipt_Generator SHALL フッターにバーコードと合計点数を表示する
5. WHEN レシートが生成される THEN THE Receipt_Generator SHALL 上下にギザギザの形状を適用する
6. WHEN レシートが生成される THEN THE Receipt_Generator SHALL ピンク色（#FFFF4081）を基調とした配色を使用する

### 要件 3: 画面モード切り替え

**ユーザーストーリー:** ユーザーとして、入力モードとプレビューモードを直感的に切り替えたい。そうすることで、スムーズな操作体験を得られる。

#### 受け入れ基準

1. WHEN アプリが起動される THEN THE UI_Controller SHALL 入力モードを初期状態として設定する
2. WHEN プレビューボタンが押される THEN THE UI_Controller SHALL プレビューモードに切り替える
3. WHEN プレビューモードに切り替わる THEN THE UI_Controller SHALL キーボードを閉じて入力エリアを非表示にする
4. WHEN 修正ボタンが押される THEN THE UI_Controller SHALL 入力モードに戻る
5. WHEN 入力モードに戻る THEN THE UI_Controller SHALL テキスト入力エリアを再表示してフォーカスを設定する

### 要件 4: 画像生成とシェア機能

**ユーザーストーリー:** ユーザーとして、作成したレシート風画像を他のアプリにシェアしたい。そうすることで、家族やパートナーに買い物依頼を送信できる。

#### 受け入れ基準

1. WHEN シェアボタンが押される THEN THE Share_Service SHALL レシートWidgetを高画質PNG画像に変換する
2. WHEN 画像変換が完了する THEN THE Share_Service SHALL OS標準のシェアシートを起動する
3. WHEN 画像が生成される THEN THE Share_Service SHALL pixelRatio 3.0以上で高画質を保証する
4. WHEN 画像変換に失敗する THEN THE Share_Service SHALL エラーメッセージを表示して元の画面を維持する
5. WHEN シェアがキャンセルされる THEN THE Share_Service SHALL プレビューモードを維持する

### 要件 5: ダークモード対応

**ユーザーストーリー:** ユーザーとして、システムのダークモード設定に応じてアプリの外観が変化することを期待する。そうすることで、一貫したユーザー体験を得られる。

#### 受け入れ基準

1. WHEN システムがダークモードに設定されている THEN THE Theme_Manager SHALL ダークテーマを適用する
2. WHEN ダークモードが適用される THEN THE Theme_Manager SHALL 背景色を黒系に変更する
3. WHEN ダークモードが適用される THEN THE Theme_Manager SHALL ピンク色をネオンサインのように映える色調に調整する
4. WHEN ライトモードが適用される THEN THE Theme_Manager SHALL 明るい背景色とピンク色の標準配色を使用する
5. WHEN テーマが変更される THEN THE Theme_Manager SHALL レシート画像の配色も対応するテーマに更新する

### 要件 6: テキスト処理とレイアウト

**ユーザーストーリー:** ユーザーとして、長い商品名や大量のアイテムを入力してもレイアウトが崩れないことを期待する。そうすることで、どんな買い物リストでも美しく表示できる。

#### 受け入れ基準

1. WHEN 長いアイテム名が入力される THEN THE Receipt_Generator SHALL 適切に改行または文字サイズを調整する
2. WHEN 大量のアイテムが入力される THEN THE Receipt_Generator SHALL レシートの高さを動的に調整する
3. WHEN 空行が含まれる入力がある THEN THE Receipt_Generator SHALL 空行を無視して処理する
4. WHEN 特殊文字が含まれる入力がある THEN THE Receipt_Generator SHALL 特殊文字を正しく表示する
5. WHEN 日本語と英語が混在する入力がある THEN THE Receipt_Generator SHALL 適切なフォントで両方を表示する

### 要件 7: ハプティクスフィードバック

**ユーザーストーリー:** ユーザーとして、操作に対する触覚的なフィードバックを感じたい。そうすることで、より楽しく直感的なアプリ体験を得られる。

#### 受け入れ基準

1. WHEN プレビューボタンが押される THEN THE System SHALL 軽いハプティクス（Light Impact）を発生させる
2. WHEN シェアボタンが押される THEN THE System SHALL 中程度のハプティクス（Medium Impact）を発生させる
3. WHEN 修正ボタンが押される THEN THE System SHALL 軽いハプティクス（Light Impact）を発生させる
4. WHEN レシート生成が完了する THEN THE System SHALL 成功を示すハプティクス（Success Notification）を発生させる
5. WHEN エラーが発生する THEN THE System SHALL エラーを示すハプティクス（Error Notification）を発生させる
6. WHEN ハプティクス機能が利用できない端末 THEN THE System SHALL 正常に動作を継続する

### 要件 8: パフォーマンスと安定性

**ユーザーストーリー:** ユーザーとして、アプリが高速で安定して動作することを期待する。そうすることで、ストレスなく買い物依頼を作成できる。

#### 受け入れ基準

1. WHEN アプリが起動される THEN THE System SHALL 3秒以内に入力可能状態になる
2. WHEN プレビューが生成される THEN THE System SHALL 2秒以内にレシート画像を表示する
3. WHEN 画像変換が実行される THEN THE System SHALL 5秒以内にシェアシートを表示する
4. WHEN メモリ不足が発生する THEN THE System SHALL 適切にエラーハンドリングを行い、アプリクラッシュを防ぐ
5. WHEN ネットワーク接続がない状態 THEN THE System SHALL オフラインでも基本機能を提供する
