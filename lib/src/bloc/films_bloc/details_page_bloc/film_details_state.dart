import 'package:smessanger/src/models/credits_model.dart';
import 'package:smessanger/src/models/movie_details_model.dart';
import 'package:smessanger/src/models/trailers_model.dart';

abstract class FilmDetailsState {}

class FilmDetailsLoading extends FilmDetailsState {}

class FilmDetailsLoaded extends FilmDetailsState {
  final DetailsModel details;
  final List<TrailersModel> trailers;
  final List<CreditsModel> credits;
  FilmDetailsLoaded(
      {required this.details, required this.trailers, required this.credits});
}

class FilmDetailsError extends FilmDetailsState {
  final String error;
  FilmDetailsError({required this.error});
}
