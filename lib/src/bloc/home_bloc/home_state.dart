import 'package:smessanger/src/models/my_profile_model.dart';

class HomeState {
  final int page;
  final UserModel? myProfile;
  final HomeStatus status;
  HomeState({this.page = 0, this.myProfile, this.status = HomeStatus.intial});
  HomeState copyWith({
    int? page,
    UserModel? myProfile,
    HomeStatus? status,
  }) {
    return HomeState(
      page: page ?? this.page,
      myProfile: myProfile ?? this.myProfile,
      status: status ?? this.status,
    );
  }
}

enum HomeStatus { loading, loaded, intial }
