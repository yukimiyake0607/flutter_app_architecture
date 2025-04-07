import 'package:flutter_app_architecture/data/repositories/auth_repository_impl.dart';
import 'package:flutter_app_architecture/domain/models/user_model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@riverpod
Stream<UserModel?> authStateStream(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
}
