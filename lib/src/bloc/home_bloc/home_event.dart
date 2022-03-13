abstract class HomeEvent {}

class HomeLoadingEvent extends HomeEvent {
  final String uid;
  HomeLoadingEvent({required this.uid});
}

class HomePageChangeEvent extends HomeEvent {
  final int page;
  HomePageChangeEvent({required this.page});
}
