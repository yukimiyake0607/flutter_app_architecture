abstract class IAuthRepository {
  Future<void> register(String email, String password);
  Future<void> login(String email, String password);
  Future<void> logout();
  Stream<void> get authStateChanges;
}
