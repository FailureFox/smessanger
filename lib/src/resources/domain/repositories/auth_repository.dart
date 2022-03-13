import 'package:flutter/cupertino.dart';

abstract class AuthRepository {
  Future<bool> isRegistered(String uid);

  Future<String> signInWithNumber(String pinCode);

  Future<void> verificationNumber({
    required String phoneNumber,
    required PageController controller,
    required BuildContext context,
  });
}
