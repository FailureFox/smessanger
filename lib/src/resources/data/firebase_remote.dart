import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:smessanger/src/models/my_profile_model.dart';

abstract class FireBaseRemote {
  Future<void> createAccount(MyProfile profile);

  Future<String> uploadFile(File file, String fileType);

  Future<bool> isRegistered(String uid);

  Future<String> getDownloadUrl(String fileName);

  Future<String> signInWithNumber(String pinCode);

  Future<void> verificationNumber({
    required String phoneNumber,
    required PageController controller,
    required BuildContext context,
  });
}
