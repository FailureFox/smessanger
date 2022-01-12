import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_event.dart';
import 'package:smessanger/src/bloc/app_bloc/app_state.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smessanger/src/bloc/app_bloc/app_status.dart';
import 'package:smessanger/src/resources/domain/repositories/token_repository.dart';

class AppBloc extends Bloc<AppEvents, AppState> {
  final TokenRepository tokenRepository;
  final SharedPreferences preferences;
  AppBloc({required this.tokenRepository, required this.preferences})
      : super(const AppState()) {
// storage.getBool('theme')
    on<AppThemeLoadingEvent>((event, emit) async {
      final theme = preferences.getBool('theme') ?? false;
      emit(state.copyWith(isDark: theme));
      final token = await tokenRepository.getToken();
      await Future.delayed(const Duration(seconds: 2));
      if (token == null) {
        emit(state.copyWith(status: AppStatus.unlogged));
      } else {
        emit(state.copyWith(status: AppStatus.logged, uid: token));
      }
    });
    on<AppThemeChangeEvent>((event, emit) {
      preferences.setBool('theme', !state.isDark);
      emit(state.copyWith(isDark: !state.isDark));
    });
    on<AppTokenLoadingEvent>((event, emit) {
      emit(state.copyWith(uid: event.uid));
    });
  }
}
