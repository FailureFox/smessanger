import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:smessanger/src/models/my_profile_model.dart';

class FireBaseRemoteUse {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String verificationId = "";

  Future<void> createAccount(MyProfile profile) async {
    print(profile.toMap());
  }

  Future<String> signInWithNumber(String pinCode) async {
    try {
      final AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: pinCode);
      final user = await _firebaseAuth.signInWithCredential(authCredential);
      return user.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  verificationNumber({
    required String phoneNumber,
    required PageController controller,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (verificationCompleted) {},
        verificationFailed: (exception) {},
        timeout: const Duration(seconds: 10),
        codeSent: (verificationId, number) {
          this.verificationId = verificationId;
          controller.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId = verificationId;
        });
  }
}
