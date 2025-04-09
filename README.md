# flutter_app_architecture

## 概要

- [Flutter App Architecture](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)を参考に自分なりのアーキテクチャを構築
- 今後のプロジェクトで使えるように解釈

## アプリ説明

- Firebase Authenticationを使用してアカウントを新規作成、ログインする単純なアプリ
- 外部データベースを使用する場合のアーキテクチャを実践

## アーキテクチャ概要

### Data層

- Firebase Authenticationと直接やりとり
- リポジトリパターンを用いてデータアクセスを抽象化
- エラーハンドリング

### Domain層

- アプリケーション固有のモデルクラス（UserModel）を定義
- ビジネスロジックの中心

### Application層

- 今回はなし
- 複数のデータソースやリポジトリを組み合わせる役割

### Presentation層

- UI（Widgets）
- State（AsyncValue）
- ユーザー操作の処理（Controller）

## 主な機能

- メールアドレス、パスワードによる新規ユーザー登録
- ログイン
- ログアウト
- 認証状態の永続化、リアルタイム監視

## 技術スタック

- Flutter：UIフレームワーク
- Firebase Authentication：ユーザー認証サービス
- Riverpod：状態管理ライブラリ
- Freezed：モデルクラス生成

## プロジェクト構造

'''
lib
├── data
│   ├── datastore
│   │   └── auth_datastore.dart
│   └── repositories
│       └── auth_repository_impl.dart
├── domain
│   ├── models
│   │   ├── result
│   │   │   ├── result.dart
│   │   │   └── result.freezed.dart
│   │   └── user_model
│   │       ├── user_model.dart
│   │       └── user_model.freezed.dart
│   └── repositories
│       └── i_auth_repository.dart
├── firebase_options.dart
├── main.dart
├── presentation
│   ├── controllers
│   │   ├── auth_controller.dart
│   │   ├── auth_controller.g.dart
│   │   ├── auth_state_provider.dart
│   │   └── auth_state_provider.g.dart
│   └── pages
│       ├── auth
│       │   ├── auth_page.dart
│       │   ├── login_page.dart
│       │   └── register_page.dart
│       ├── core
│       │   ├── error_page.dart
│       │   └── loading_page.dart
│       ├── home_page.dart
│       └── user_session.dart
└── router.dart
'''


