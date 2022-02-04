abstract class HttpDomain {
  Future<Map<String, dynamic>> get(
      {required String url, required String path, Map<String, dynamic>? query});
}
