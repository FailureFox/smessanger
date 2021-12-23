import 'package:smessanger/src/resources/domain/repositories/news_repositories.dart';

class NewsRepositoryUse extends NewsRepositories {
  @override
  getCountryNews(String country) {
    throw UnimplementedError();
  }

  @override
  getNewNews() {
    throw UnimplementedError();
  }

  @override
  getPopularityNews() {
    throw UnimplementedError();
  }
}
