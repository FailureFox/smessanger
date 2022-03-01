import 'package:smessanger/src/models/films_model.dart';

abstract class FilmsState {}

class FilmsLoadingState extends FilmsState {}

class FilmsLoadedState extends FilmsState {
  final List<FilmsModel> popularityFilms;
  final List<FilmsModel> trandingFilms;
  FilmsLoadedState(
      {this.popularityFilms = const [], this.trandingFilms = const []});
}

class FilmsLoadingStateError extends FilmsState {
  final String exception;
  FilmsLoadingStateError({required this.exception});
}
