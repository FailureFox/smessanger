import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smessanger/src/resources/domain/repositories/token_repository.dart';

class TokenRepositoryUse extends TokenRepository {
  final FlutterSecureStorage securestorage;
  TokenRepositoryUse({required this.securestorage});

  @override
  Future<void> saveToken(String uid) async {
    await securestorage.write(key: 'token', value: uid);
  }

  @override
  Future<String?> getToken() async {
    return await securestorage.read(key: 'token');
  }
}
