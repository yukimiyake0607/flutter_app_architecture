import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
  }) = _UserModel;

  factory UserModel.fromUserCredential(UserCredential userCredential) {
    final user = userCredential.user;
    if (user == null || user.email == null) {
      throw Exception('Firebaseから無効なユーザー情報を取得しました');
    }
    return UserModel(
      id: user.uid,
      email: user.email!,
    );
  }

  factory UserModel.fromUser(User? user) {
    if (user == null || user.email == null) {
      throw Exception('無効なユーザー情報です');
    }
    return UserModel(id: user.uid, email: user.email!);
  }
}
