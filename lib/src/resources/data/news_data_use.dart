import 'dart:convert';
import 'package:smessanger/src/models/news_model.dart';
import 'package:smessanger/src/resources/data/news_data.dart';
import 'package:smessanger/src/resources/domain/repositories/http_domain.dart';

class NewsDataUse extends NewsData {
  final HttpDomain httpDomain;
  NewsDataUse({required this.httpDomain});
  static const String apiKey = '014f21b647fb4c82bbe7117c8bb13fbd';
  static const String url = 'newsapi.org';
  @override
  Future<List<NewsModel>> getCountryNews(String country) async {
    try {
      final myJson = await httpDomain.get(
        url: url,
        path: '/v2/top-headlines/',
        query: {
          'apiKey': apiKey,
          'country': country,
        },
      );
      return (myJson['articles'] as List<dynamic>)
          .map((e) => NewsModel.fromMap(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
