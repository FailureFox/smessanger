import 'package:smessanger/src/bloc/app_bloc/app_status.dart';

class AppState {
  final bool isDark;
  final AppStatus status;
  final String uid;
  const AppState(
      {this.isDark = true, this.status = AppStatus.initial, this.uid = ''});
  AppState copyWith({bool? isDark, AppStatus? status, String? uid}) {
    return AppState(
      isDark: isDark ?? this.isDark,
      status: status ?? this.status,
      uid: uid ?? this.uid,
    );
  }
}
