abstract class UserRepository {
  Future<User?> register(String email, String password);
}