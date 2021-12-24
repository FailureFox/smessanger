import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc.dart';

class FireBaseRemoteUse {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String verificationId = "";

  Future<void> signInWithNumber(String pinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: pinCode);
    await _firebaseAuth.signInWithCredential(authCredential);
  }

  verificationNumber({
    required String phoneNumber,
    required PageController controller,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (verificationCompleted) {
          print(verificationCompleted.token);
        },
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
