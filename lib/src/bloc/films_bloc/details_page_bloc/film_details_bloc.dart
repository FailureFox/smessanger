import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/films_bloc/details_page_bloc/film_details_state.dart';
import 'package:smessanger/src/models/credits_model.dart';
import 'package:smessanger/src/models/movie_details_model.dart';
import 'package:smessanger/src/models/trailers_model.dart';
import 'package:smessanger/src/resources/domain/repositories/films_repositories/films_repository.dart';

class FilmDetailsBloc extends Cubit<FilmDetailsState> {
  final int filmId;
  final FilmsDomain domain;
  final String region;
  FilmDetailsBloc({
    required this.filmId,
    required this.domain,
    required this.region,
  }) : super(FilmDetailsLoading()) {
    loadingDetails();
  }

  Future<void> loadingDetails() async {
    try {
      emit(FilmDetailsLoading());
      final DetailsModel details = await domain.getMovieDetails(
          id: filmId, region: region, language: 'en');
      final List<TrailersModel> trailers = await domain.getTrailers(filmId);
      final List<CreditsModel> credits = await domain.getCredits(filmId);
      emit(
        FilmDetailsLoaded(
            details: details, trailers: trailers, credits: credits),
      );
    } catch (e) {
      print(e);
      emit(FilmDetailsError(error: e.toString()));
    }
  }
}
