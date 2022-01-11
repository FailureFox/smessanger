import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:smessanger/src/resources/domain/repositories/file_repository.dart';

class FileRepositoryUse extends FileRepository {
  FirebaseStorage firebaseStorage;
  FileRepositoryUse({required this.firebaseStorage});
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
  Future<String> getDownloadUrl(String fileName) async {
    return await firebaseStorage.ref(fileName).getDownloadURL();
  }
}
