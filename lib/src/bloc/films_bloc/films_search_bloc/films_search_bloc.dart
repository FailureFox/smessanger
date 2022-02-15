import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/films_bloc/films_search_bloc/films_search_state.dart';

class FilmsSearchBloc extends Cubit<FilmsSearchState> {
  FilmsSearchBloc(FilmsSearchState initialState) : super(initialState);
}
