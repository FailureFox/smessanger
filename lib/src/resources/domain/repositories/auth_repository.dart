import 'package:flutter/cupertino.dart';
import 'package:smessanger/src/models/my_profile_model.dart';

abstract class AuthRepository {
  Future<String> createAccount(MyProfile profile);

  Future<bool> isRegistered(String uid);

  Future<String> signInWithNumber(String pinCode);

  Future<void> verificationNumber({
    required String phoneNumber,
    required PageController controller,
    required BuildContext context,
  });
}
