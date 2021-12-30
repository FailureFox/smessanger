import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_event.dart';
import 'package:smessanger/src/bloc/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomePageChangeEvent>(
        (event, emit) => emit(state.copyWith(page: event.page)));
  }
}
