import 'dart:convert';
import 'package:smessanger/src/models/news_model.dart';
import 'package:smessanger/src/resources/data/news_data.dart';
import 'package:http/http.dart' as http;

class NewsDataUse extends NewsData {
  static const String apiKey = 'apiKey=014f21b647fb4c82bbe7117c8bb13fbd';
  static const String url = 'https://newsapi.org/v2/top-headlines?';
  @override
  Future<List<NewsModel>> getCountryNews(String country) async {
    Uri uri = Uri.parse(url + apiKey + '&country=$country');
    final response = await http.get(uri);

    try {
      final jsonString = response.body;
      return (jsonDecode(jsonString)['articles'] as List<dynamic>)
          .map((e) => NewsModel.fromMap(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  getPopularityNews() {}
}

class MyVerifyClass {
  int a = 5;
}
