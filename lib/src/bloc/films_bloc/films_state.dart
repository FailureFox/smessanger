import 'package:smessanger/src/models/films_model.dart';

class FilmsState {
  final List<FilmsModel> popularityFilms;
  final List<FilmsModel> trandingFilms;
  late bool isLoaded;
  FilmsState({this.popularityFilms = const [], this.trandingFilms = const []}) {
    if (trandingFilms.isNotEmpty && popularityFilms.isNotEmpty) {
      isLoaded = true;
    }
  }

  copyWith(
      {List<FilmsModel>? popularityFilms, List<FilmsModel>? trandingFilms}) {
    return FilmsState(
      popularityFilms: popularityFilms ?? this.popularityFilms,
      trandingFilms: trandingFilms ?? this.trandingFilms,
    );
  }
}
