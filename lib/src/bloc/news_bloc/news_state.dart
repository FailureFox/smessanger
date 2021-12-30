import 'package:smessanger/src/bloc/news_bloc/news_status.dart';
import 'package:smessanger/src/models/news_model.dart';

class NewsState {
  List<NewsModel> news;
  NewsStatus status;
  NewsState({
    this.news = const [],
    this.status = NewsStatus.initial,
  });
  NewsState copyWIth({
    List<NewsModel>? news,
    NewsStatus? status,
  }) {
    return NewsState(
      news: news ?? this.news,
      status: status ?? this.status,
    );
  }
}
