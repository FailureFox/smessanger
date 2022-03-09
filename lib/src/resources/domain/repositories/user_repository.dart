import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/usecases/user_repository_use.dart';

abstract class UserRepository {
  Future<String> setUser(UserModel profile);
  Future<List<UserModel>> searchUser(
      {required String text, required UsersSearchType searchType});
  Stream<UserModel> getUser(String uid);
  Future<UserModel> getAsyncUser(String uid);
}
