import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_event.dart';
import 'package:smessanger/src/bloc/app_bloc/app_state.dart';

class AppBloc extends Bloc<AppEvents, AppState> {
  AppBloc() : super(AppState()) {
    on<AppThemeLoadingEvent>((event, emit) => null);
    on<AppThemeChangeEvent>((event, emit) {
      emit(state.copyWith(isDark: !state.isDark));
    });
  }
}
