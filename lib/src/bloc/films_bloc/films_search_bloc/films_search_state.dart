import 'package:smessanger/src/bloc/films_bloc/films_search_bloc/films_search_bloc.dart';

abstract class FilmsSearchState {}

class FilmsSearchInitial extends FilmsSearchState {}

class FilmsSearchLoading extends FilmsSearchState {}

class FilmsSearchLoaded extends FilmsSearchState {
  final List<FilmsSearchEntity> movies;
  final int thisPage;

  FilmsSearchLoaded({required this.movies, required this.thisPage});
}

class FilmsSearchEmpty extends FilmsSearchState {}

class FilmsSearchError extends FilmsSearchState {}
