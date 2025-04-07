import 'package:flutter_app_architecture/data/datastore/auth_datastore.dart';
import 'package:flutter_app_architecture/domain/models/user_model/user_model.dart';
import 'package:flutter_app_architecture/domain/repositories/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AuthRepositoryを提供
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final authDatastore = ref.watch(authDatastoreProvider);
  return AuthRepositoryImpl(authDatastore);
});

// AuthDatastoreで受け取った生データをUserModelに変換、エラーハンドリングをする
class AuthRepositoryImpl implements IAuthRepository {
  final AuthDatastore _authDatastore;

  AuthRepositoryImpl(this._authDatastore);

  // datastoreから受け取ったUserCredentialをUserModelへ変換
  @override
  Future<UserModel?> register(String email, String password) async {
    try {
      final userCredential =
          await _authDatastore.createUserWithEmailAndPassword(email, password);
      final user = UserModel.fromUserCredential(userCredential);
      return user;
    } on Exception catch (e) {
      throw Exception('ユーザー登録に失敗しました: $e');
    }
  }

  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      final userCredential =
          await _authDatastore.loginWithEmailAndPassword(email, password);
      final user = UserModel.fromUserCredential(userCredential);
      return user;
    } on Exception catch (e) {
      throw Exception('ログインに失敗しました: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _authDatastore.logout();
    } on Exception catch (e) {
      throw Exception('ログアウトに失敗しました: $e');
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    try {
      return _authDatastore.authStateChanges
          .map((user) => user != null ? UserModel.fromUser(user) : null);
    } on Exception catch (e) {
      throw Exception('ユーザー情報取得に失敗しました: $e');
    }
  }
}
