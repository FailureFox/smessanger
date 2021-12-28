import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smessanger/src/bloc/app_bloc/app_event.dart';
import 'package:smessanger/src/bloc/app_bloc/app_state.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smessanger/src/bloc/app_bloc/app_status.dart';

class AppBloc extends Bloc<AppEvents, AppState> {
  AppBloc() : super(const AppState()) {
    late SharedPreferences storage;
    FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

    on<AppThemeLoadingEvent>((event, emit) async {
      storage = await SharedPreferences.getInstance();
      emit(state.copyWith(isDark: storage.getBool('theme')));
      final token = await _secureStorage.read(key: 'token');
      await Future.delayed(const Duration(seconds: 2));

      if (token == null) {
        emit(state.copyWith(status: AppStatus.unlogged));
      } else {
        emit(state.copyWith(status: AppStatus.logged, uid: token));
      }
    });
    on<AppThemeChangeEvent>((event, emit) {
      storage.setBool('theme', !state.isDark);
      emit(state.copyWith(isDark: !state.isDark));
    });
    on<AppTokenLoadingEvent>((event, emit) {
      emit(state.copyWith(uid: event.uid));
    });
  }
}
