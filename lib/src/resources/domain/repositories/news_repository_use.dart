import 'package:smessanger/src/models/news_model.dart';
import 'package:smessanger/src/resources/data/news_data_use.dart';
import 'package:smessanger/src/resources/domain/repositories/news_repositories.dart';

class NewsRepositoryUse extends NewsRepositories {
  final NewsDataUse news;
  NewsRepositoryUse({required this.news});

  @override
  Future<List<NewsModel>> getCountryNews(String country) async {
    return await news.getCountryNews(country);
  }

  @override
  getPopularityNews() {
    throw UnimplementedError();
  }
}
