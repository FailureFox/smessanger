import 'package:smessanger/src/models/films_model.dart';
import 'package:smessanger/src/resources/domain/repositories/http_domain.dart';

class FilmsDomain {
  final HttpDomain httpDomain;
  FilmsDomain({required this.httpDomain});
  static const String apiKey = '05bee1008ffaf3bd8c492523b4f24aa4';
  static const String link = 'api.themoviedb.org';
  Future<List<FilmsModel>> getFilmsList(
      {int? page, required String region, required String path}) async {
    final Map<String, dynamic> films =
        await httpDomain.get(url: link, path: path, query: {
      'api_key': apiKey,
      'region': region,
      if (page != null) 'page': page,
    });
    return (films['results'] as List)
        .map((e) => FilmsModel.fromMap(e))
        .toList();
  }

}
