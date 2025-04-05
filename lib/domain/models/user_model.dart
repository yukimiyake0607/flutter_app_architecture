import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._(); // これを追加
  
  const factory UserModel({
    required String id,
    required String email,
  }) = _UserModel;
}