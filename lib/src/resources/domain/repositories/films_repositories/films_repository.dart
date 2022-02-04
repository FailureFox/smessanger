import 'package:smessanger/src/models/films_model.dart';
import 'package:smessanger/src/resources/domain/repositories/http_domain.dart';

class FilmsDomain {
  final HttpDomain httpDomain;
  FilmsDomain({required this.httpDomain});
  static const String apiKey = '05bee1008ffaf3bd8c492523b4f24aa4';
  static const String link = 'api.themoviedb.org';
  Future<List<FilmsModel>> getPopularityFilms(
      {int? page, required String region}) async {
    final Map<String, dynamic> films =
        await httpDomain.get(url: link, path: '/3/movie/popular', query: {
      'api_key': apiKey,
      'region': region,
      if (page != null) 'page': page,
    });
    print(films);
    return (films['results'] as List)
        .map((e) => FilmsModel.fromMap(e))
        .toList();
  }

  Future<List<FilmsModel>> getTrandingFilms(
      {int? page, required String region}) async {
    final Map<String, dynamic> films = await httpDomain.get(
        url: link, path: '/3/trending/movie/day', query: {'api_key': apiKey});
    return (films['results'] as List)
        .map((e) => FilmsModel.fromMap(e))
        .toList();
  }
}
