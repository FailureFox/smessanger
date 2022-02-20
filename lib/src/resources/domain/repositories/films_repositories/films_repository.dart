import 'package:smessanger/src/bloc/films_bloc/films_search_bloc/films_search_bloc.dart';
import 'package:smessanger/src/models/credits_model.dart';
import 'package:smessanger/src/models/films_model.dart';
import 'package:smessanger/src/models/movie_details_model.dart';
import 'package:smessanger/src/models/trailers_model.dart';
import 'package:smessanger/src/resources/domain/repositories/http_domain.dart';

class FilmsDomain {
  final HttpDomain httpDomain;
  FilmsDomain({required this.httpDomain});
  static const String apiKey = '05bee1008ffaf3bd8c492523b4f24aa4';
  static const String link = 'api.themoviedb.org';
  static const Map<String, dynamic> query = {
    'api_key': apiKey,
    'language': 'en - US'
  };

  Future<List<FilmsModel>> getFilmsList(
      {int? page, required String region, required String path}) async {
    try {
      final Map<String, dynamic> films =
          await httpDomain.get(url: link, path: path, query: {
        'api_key': apiKey,
        'region': region,
        if (page != null) 'page': page,
      });
      return (films['results'] as List)
          .map((e) => FilmsModel.fromMap(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DetailsModel> getMovieDetails({
    required int id,
    required String region,
    required String language,
  }) async {
    try {
      final path = '/3/movie/$id';
      final json = await httpDomain.get(url: link, path: path, query: query);
      final DetailsModel details = DetailsModel.fromMap(json);
      return details;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TrailersModel>> getTrailers(int id) async {
    try {
      final Map<String, dynamic> videosMap = await httpDomain.get(
          url: link, path: '/3/movie/$id/videos', query: query);
      final List trailers = (videosMap['results'] as List);
      return trailers.map((e) => TrailersModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CreditsModel>> getCredits(int id) async {
    try {
      final String path = '3/movie/$id/credits';
      final Map<String, dynamic> creditsMap =
          await httpDomain.get(url: link, path: path, query: query);
      final List credits = creditsMap['cast'] as List;
      return credits.map((e) => CreditsModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<FilmsSearchEntity>> getSearchMovies(String text) async {
    try {
      Map<String, dynamic> myQuery = {
        'api_key': apiKey,
        'language': 'en - US',
        'query': text,
      };
      const String path = '/3/search/movie';
      final Map<String, dynamic> map =
          await httpDomain.get(url: link, path: path, query: myQuery);
      final result = map['results'] as List;
      return result.map((e) => FilmsSearchEntity.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
