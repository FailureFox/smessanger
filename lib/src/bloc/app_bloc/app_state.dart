class AppState {
  final bool isDark;
  const AppState({this.isDark = false});
  AppState copyWith({bool? isDark}) {
    return AppState(isDark: isDark ?? this.isDark);
  }
}
