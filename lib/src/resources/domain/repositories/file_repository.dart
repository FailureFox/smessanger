import 'dart:io';

abstract class FileRepository {
  Future<String> uploadFile(File file, String filePath);

  Future<String> getDownloadUrl(String fileName);
}
