import 'dart:convert';
import 'dart:io';

import 'package:smessanger/src/models/news_model.dart';
import 'package:smessanger/src/resources/data/news_data_use.dart';

class NewsDataUse extends NewsData {
  final HttpClient client = HttpClient();
  static const String apiKey = 'apiKey=014f21b647fb4c82bbe7117c8bb13fbd';
  static const String url = 'https://newsapi.org/v2/top-headlines?';
  @override
  getCountryNews(String country) async {
    Uri uri = Uri.parse(url + apiKey + '&country=$country');

    final response = await client.getUrl(uri);

    final request = await response.close();
    final jsonString = (await request.transform(utf8.decoder).toList()).join();
    final a = (jsonDecode(jsonString)['articles'] as List<dynamic>)
        .map((e) => NewsModel.fromMap(e))
        .toList();

    for (var item in a) {
      print(item.content);
    }
  }

  @override
  getPopularityNews() {
    // TODO: implement getPopularityNews
    throw UnimplementedError();
  }
}
