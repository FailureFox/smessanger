import 'package:smessanger/src/models/my_profile_model.dart';

abstract class UserRepository {
  Future<String> setUser(UserModel profile);
  Future<List<UserModel>> searchUser(String userName);
  Stream<UserModel> getUser(String uid);
}
