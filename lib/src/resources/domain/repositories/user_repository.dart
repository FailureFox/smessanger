import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/models/user_model.dart';

abstract class UserRepository {
  Stream<MyProfile> getMyUser(uid);

  Stream<UserModel> getChatUser(String uid);
}
