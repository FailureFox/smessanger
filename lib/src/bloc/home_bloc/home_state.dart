import 'package:smessanger/src/models/my_profile_model.dart';

class HomeState {
  final int page;
  final MyProfile? myProfile;
  HomeState({this.page = 0, this.myProfile});
  HomeState copyWith({
    int? page,
    MyProfile? myProfile,
  }) {
    return HomeState(
      page: page ?? this.page,
      myProfile: myProfile ?? this.myProfile,
    );
  }
}
