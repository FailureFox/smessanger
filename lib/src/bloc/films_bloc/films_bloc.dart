import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/resources/domain/repositories/films_repositories/films_repository.dart';
import 'films_state.dart';

class FilmsBloc extends Cubit<FilmsState> {
  final FilmsDomain filmsDomain;
  FilmsBloc({required this.filmsDomain, required String region})
      : super(FilmsState()) {
    loadFilms(region);
  }

  loadFilms(String region) async {
    final popularityFilms = await filmsDomain.getFilmsList(
        region: region, path: '/3/movie/popular');
    final trandingFilms = await filmsDomain.getFilmsList(
        region: region, path: '/3/trending/movie/day');
    emit(state.copyWith(
        popularityFilms: popularityFilms, trandingFilms: trandingFilms));
  }
}
