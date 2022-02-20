import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/films_bloc/films_search_bloc/films_search_state.dart';
import 'package:smessanger/src/resources/domain/repositories/films_repositories/films_repository.dart';

class FilmsSearchBloc extends Cubit<FilmsSearchState> {
  final String region;
  final FilmsDomain domain;
  FilmsSearchBloc({required this.region, required this.domain})
      : super(FilmsSearchInitial());

  searchFilms({required String text}) async {
    if (text != '') {
      try {
        emit(FilmsSearchLoading());
        final List<FilmsSearchEntity> movies =
            await domain.getSearchMovies(text);
        if (movies.isNotEmpty) {
          emit(FilmsSearchLoaded(movies: movies, thisPage: 0));
        } else {
          emit(FilmsSearchEmpty());
        }
      } catch (e) {
        emit(FilmsSearchError());
      }
    } else {
      emit(FilmsSearchInitial());
    }
  }
}

class FilmsSearchEntity {
  final String? posterPath;
  final bool adult;
  final String overview;
  final DateTime releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  FilmsSearchEntity({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

  factory FilmsSearchEntity.fromMap(Map<String, dynamic> map) {
    return FilmsSearchEntity(
      posterPath: map['poster_path'],
      adult: map['adult'] ?? false,
      overview: map['overview'] ?? '',
      releaseDate: DateTime.parse(map['release_date']),
      genreIds: List<int>.from(map['genre_ids']),
      id: map['id']?.toInt() ?? 0,
      originalTitle: map['original_title'] ?? '',
      originalLanguage: map['original_language'] ?? '',
      title: map['title'] ?? '',
      backdropPath: map['backdrop_path'],
      popularity: map['popularity']?.toDouble() ?? 0.0,
      voteCount: map['vote_count']?.toInt() ?? 0,
      video: map['video'] ?? false,
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
    );
  }

  factory FilmsSearchEntity.fromJson(String source) =>
      FilmsSearchEntity.fromMap(json.decode(source));
}
