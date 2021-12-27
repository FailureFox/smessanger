import 'package:smessanger/src/bloc/app_bloc/app_status.dart';

class AppState {
  final bool isDark;
  final AppStatus status;
  const AppState({this.isDark = true, this.status = AppStatus.initial});
  AppState copyWith({bool? isDark, AppStatus? status}) {
    return AppState(
      isDark: isDark ?? this.isDark,
      status: status ?? this.status,
    );
  }
}
