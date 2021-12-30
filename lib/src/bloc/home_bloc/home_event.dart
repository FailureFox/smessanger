abstract class HomeEvent {}

class HomeLoadingEvent extends HomeEvent {}

class HomePageChangeEvent extends HomeEvent {
  final int page;
  HomePageChangeEvent({required this.page});
}
