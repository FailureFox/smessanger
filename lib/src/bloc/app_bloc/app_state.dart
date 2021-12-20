class AppState {
  final bool isDark;
  const AppState({this.isDark = true});
  AppState copyWith({bool? isDark}) {
    return AppState(isDark: isDark ?? this.isDark);
  }
}
