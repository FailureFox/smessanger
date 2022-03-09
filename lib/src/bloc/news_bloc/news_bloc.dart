import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/news_bloc/news_event.dart';
import 'package:smessanger/src/bloc/news_bloc/news_state.dart';
import 'package:smessanger/src/bloc/news_bloc/news_status.dart';
import 'package:smessanger/src/models/news_model.dart';
import 'package:smessanger/src/resources/data/news_data.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsData newsData;
  NewsBloc({required this.newsData}) : super(NewsState()) {
    on<NewsLoadingEvent>((event, emit) async {
      try {
        emit(state.copyWIth(status: NewsStatus.loading));
        final List<NewsModel> news = (await newsData.getCountryNews('us'));
        for (var i = 0; i < news.length; i++) {
          if (news[i].urlToImage == '') {
            news.removeAt(i);
            i--;
          }
        }
        emit(state.copyWIth(news: news, status: NewsStatus.loaded));
      } catch (e) {
        print(e);
        emit(state.copyWIth(status: NewsStatus.error));
      }
    });
  }
}
