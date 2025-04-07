import 'package:flutter_app_architecture/data/repositories/auth_repository_impl.dart';
import 'package:flutter_app_architecture/domain/models/user_model/user_model.dart';
import 'package:flutter_app_architecture/presentation/controllers/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<UserModel?> build() {
    // Streamをリッスンし変化に応じて更新
    ref.listen(authStateStreamProvider, (previous, next) {
      next.whenData((user) {
        return AsyncValue.data(user);
      });
    });
    return const AsyncValue.loading();
  }

  Future<void> register(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final authRepository = ref.read(authRepositoryProvider);
      final user = await authRepository.register(email, password);
      state = AsyncValue.data(user);
    } on Exception catch (e, _) {
      state = AsyncValue.error(e, _);
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final authRepository = ref.read(authRepositoryProvider);
      final user = await authRepository.login(email, password);
      state = AsyncValue.data(user);
    } on Exception catch (e, _) {
      state = AsyncValue.error(e, _);
    }
  }

  Future<void> logout(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.logout();
      state = const AsyncValue.data(null);
    } on Exception catch (e, _) {
      state = AsyncValue.error(e, _);
    }
  }
}
