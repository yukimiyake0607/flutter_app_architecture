import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// FirebaseAuth.instanceを提供
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

// AuthDatastoreをグローバルに提供
final authDatastoreProvider = Provider<AuthDatastore>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthDatastore(firebaseAuth);
});


// Firebaseと直接やりとりするロジッククラス
class AuthDatastore {
  final FirebaseAuth _firebaseAuth;

  const AuthDatastore(this._firebaseAuth);

  // Firebaseにユーザー登録処理を送信
  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on Exception catch (e) {
      throw Exception('ユーザー登録に失敗しました： $e');
    }
  }

  // Firebaseにログイン処理を送信
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on Exception catch (e) {
      throw Exception('ログインに失敗しました： $e');
    }
  }

  // Firebaseにログアウト処理を送信
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception catch (e) {
      throw Exception('ログアウトに失敗しました： $e');
    }
  }

  // ユーザーの認証状態をFirebaseから教えてもらう
  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }
}
