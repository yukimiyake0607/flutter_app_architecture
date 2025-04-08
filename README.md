# flutter_app_architecture

## 概要

- [Flutter App Architecture](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)を参考に自分なりのアーキテクチャを構築する
- 今後のプロジェクトで使えるように解釈する

## アプリ説明

- Firebase Authenticationを使用してアカウントを新規作成、ログインする単純なアプリ
- 外部データベースを使用する場合のアーキテクチャを実践

## アーキテクチャ説明

### AuthDatastore

- Firebase Authenticationと直接やりとり

### AuthRepository

- エラーハンドリング
- AuthDatastoreから取得した値をUserModelに変換
- 例外をキャッチした場合はExceptionをスロー

### AuthController

- ViewModelと同じ役割
- 初期値はnull
- AuthRepositoryから取得した値をAsyncValue型のデータ（State）に変換

### UI

- LoginPage、RegisterPageでlisten
- AuthControllerの値が変化したらメソッドを実行
