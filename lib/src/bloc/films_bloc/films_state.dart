import 'package:smessanger/src/models/films_model.dart';

abstract class FilmsState {}

class FilmsLoadingState extends FilmsState {}

class FilmsLoadedState extends FilmsState {
  final List<FilmsModel> popularityFilms;
  final List<FilmsModel> trandingFilms;
  late bool isLoaded;
  FilmsLoadedState(
      {this.popularityFilms = const [], this.trandingFilms = const []}) {
    if (trandingFilms.isNotEmpty && popularityFilms.isNotEmpty) {
      isLoaded = true;
    }
  }

  copyWith(
      {List<FilmsModel>? popularityFilms, List<FilmsModel>? trandingFilms}) {
    return FilmsLoadedState(
      popularityFilms: popularityFilms ?? this.popularityFilms,
      trandingFilms: trandingFilms ?? this.trandingFilms,
    );
  }
}

class FilmsLoadingStateError extends FilmsState {
  final String exception;
  FilmsLoadingStateError({required this.exception});
}
