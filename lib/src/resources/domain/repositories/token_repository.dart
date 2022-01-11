abstract class TokenRepository {
  Future<void> saveToken(String uid);

  Future<String?> getToken();
}
