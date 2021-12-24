import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc.dart';

class FireBaseRemoteUse {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String verificationId = "";

  signInWithNumber(String pinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: pinCode);
    _firebaseAuth.signInWithCredential(authCredential);
  }

  verificationNumber({required String phoneNumber}) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (verificationCompleted) {
          print(verificationCompleted.token);
        },
        verificationFailed: (exception) {},
        timeout: const Duration(seconds: 10),
        codeSent: (verificationId, number) {
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId = verificationId;
        });
  }
}
