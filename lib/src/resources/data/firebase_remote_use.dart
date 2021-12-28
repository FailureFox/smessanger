import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/resources/data/firebase_remote.dart';

class FireBaseRemoteUse extends FireBaseRemote {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  String verificationId = "";
  String error = '';
  FireBaseRemoteUse({
    required this.firebaseAuth,
    required this.firestore,
    required this.firebaseStorage,
  });

  @override
  Future<void> createAccount(MyProfile profile) async {}

  @override
  Future<String> uploadFile(File file, String filePath) async {
    try {
      final basePath = filePath + file.path.split('/').last;
      final myfile = await firebaseStorage.ref(basePath).putFile(file);
      return myfile.ref.fullPath;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> isRegistered(String uid) async {
    return (await firestore.collection('users').doc(uid).get()).exists;
  }

  @override
  Future<String> getDownloadUrl(String fileName) async {
    return await firebaseStorage.ref(fileName).getDownloadURL();
  }

  @override
  Future<String> signInWithNumber(String pinCode) async {
    try {
      final AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: pinCode);
      final user = await firebaseAuth.signInWithCredential(authCredential);
      return user.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> verificationNumber({
    required String phoneNumber,
    required PageController controller,
    required BuildContext context,
  }) async {
    firebaseAuth.verifyPhoneNumber(
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
