class HomeState {
  final int page;
  HomeState({this.page = 0});
  HomeState copyWith({int? page}) {
    return HomeState(page: page ?? this.page);
  }
}
