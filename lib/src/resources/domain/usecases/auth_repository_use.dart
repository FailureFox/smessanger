import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/resources/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthRepositoryUse extends AuthRepository {
  String verificationId = "";
  String error = '';
  FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  AuthRepositoryUse({required this.firestore, required this.firebaseAuth});

  @override
  Future<bool> isRegistered(String uid) async {
    try {
      return (await firestore.collection('users').doc(uid).get()).exists;
    } catch (e) {
      throw Exception(e);
    }
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
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId = verificationId;
      },
    );
  }
}
