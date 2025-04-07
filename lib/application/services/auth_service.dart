import 'package:flutter_app_architecture/data/repositories/auth_repository_impl.dart';
import 'package:flutter_app_architecture/domain/models/result/result.dart';
import 'package:flutter_app_architecture/domain/models/user_model/user_model.dart';
import 'package:flutter_app_architecture/domain/repositories/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthService(authRepository);
});

// 結果をResultクラスに変換
class AuthService {
  final IAuthRepository _authRepository;

  const AuthService(this._authRepository);

  Future<Result<UserModel, Exception>> register(
    String email,
    String password,
  ) async {
    try {
      final user = await _authRepository.register(email, password);
      return Result.success(user!);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<UserModel, Exception>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await _authRepository.login(email, password);
      return Result.success(user!);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<void, Exception>> logout() async {
    try {
      await _authRepository.logout();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Stream<Result<UserModel?, Exception>> get authStateChanges {
    return _authRepository.authStateChanges.map((user) {
      try {
        return Result.success(user);
      } on Exception catch (e) {
        return Result.failure(e);
      }
    });
  }
}
