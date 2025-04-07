import 'package:flutter_app_architecture/domain/models/user_model/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel?> register(String email, String password);
  Future<UserModel?> login(String email, String password);
  Future<void> logout();
  Stream<UserModel?> get authStateChanges;
}
