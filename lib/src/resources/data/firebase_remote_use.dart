import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

class FireBaseRemoteUse {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String verificationId = "";
  String error = '';
  Future<void> createAccount(MyProfile profile) async {}

  Future<String> uploadFile(File file, String fileType) async {
    try {
      final basePath = fileType + file.path.split('/').last;

      final myfile = await _firebaseStorage.ref(basePath).putFile(file);
      return myfile.ref.fullPath;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> isRegistered(String uid) async {
    return (await _firestore.collection('users').doc(uid).get()).exists;
  }

  Future<String> getDownloadUrl(String fileName) async {
    return await _firebaseStorage.ref(fileName).getDownloadURL();
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
    required BuildContext context,
  }) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (verificationCompleted) {},
        verificationFailed: (exception) {
          context
              .read<AuthBloc>()
              .add(AuthErrorEvent(message: exception.message ?? 'Ошибка'));
        },
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
