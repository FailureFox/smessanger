import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/resources/data/firebase_remote.dart';

class FireBaseRemoteUse extends FireBaseRemote {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  final FlutterSecureStorage securestorage;
  String verificationId = "";
  String error = '';
  FireBaseRemoteUse({
    required this.firebaseAuth,
    required this.firestore,
    required this.firebaseStorage,
    required this.securestorage,
  });

  @override
  Stream<MyProfile> getMyUser(uid) {
    return firestore.collection('users').doc(uid).snapshots().map((event) =>
        MyProfile.fromMap(event.data() as Map<String, dynamic>, uid));
  }

  @override
  Future<void> saveToken(String uid) async {
    await securestorage.write(key: 'token', value: uid);
  }

  @override
  Future<void> createAccount(MyProfile profile) async {
    try {
      firestore.collection('users').doc(profile.uid).set(profile.toMap());
      saveToken(profile.uid);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadFile(File file, String filePath) async {
    try {
      final basePath = filePath + file.path.split('/').last;
      final myfile = await firebaseStorage.ref(basePath).putFile(file);
      return await getDownloadUrl(myfile.ref.fullPath);
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
