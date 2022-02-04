import 'package:smessanger/src/models/news_model.dart';

abstract class NewsData {
  Future<List<NewsModel>> getCountryNews(String country);
}
