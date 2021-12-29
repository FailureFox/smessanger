import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:smessanger/src/resources/data/firebase_remote.dart';
import 'dart:io';

import 'package:smessanger/src/resources/domain/repositories/firebase_repository.dart';

class FireBaseRepositoryUse extends FireBaseRepository {
  final FireBaseRemote firebase;
  FireBaseRepositoryUse({required this.firebase});

  @override
  Future<void> saveToken(String uid) async {
    await firebase.saveToken(uid);
  }

  @override
  Future<void> createAccount(MyProfile profile) async {
    try {
      await firebase.createAccount(profile);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> getDownloadUrl(String fileName) async {
    try {
      return await firebase.getDownloadUrl(fileName);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> isRegistered(String uid) async {
    try {
      return await firebase.isRegistered(uid);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> signInWithNumber(String pinCode) async {
    try {
      return await firebase.signInWithNumber(pinCode);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadFile(File file, String fileType) async {
    try {
      return await firebase.uploadFile(file, fileType);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> verificationNumber({
    required String phoneNumber,
    required PageController controller,
    required BuildContext context,
  }) async {
    await firebase.verificationNumber(
      phoneNumber: phoneNumber,
      controller: controller,
      context: context,
    );
  }
}
