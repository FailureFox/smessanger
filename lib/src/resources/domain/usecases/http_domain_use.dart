import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smessanger/src/resources/domain/repositories/http_domain.dart';

class HttpDomainUse extends HttpDomain {
  @override
  Future<Map<String, dynamic>> get(
      {required String url,
      required String path,
      Map<String, dynamic>? query}) async {
    try {
      Uri uri = Uri.https(url, path, query);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonString = response.body;
        return jsonDecode(jsonString);
      } else {
        print(jsonDecode(response.body));
        throw Exception('Ошибка');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
