import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_event.dart';
import 'package:smessanger/src/bloc/home_bloc/home_state.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository repository;
  HomeBloc({required this.repository}) : super(HomeState()) {
    on<HomeLoadingEvent>(
      (event, emit) {
        emit(state.copyWith(status: HomeStatus.loading));
        repository.getUser(event.uid).listen(
              (event) => myUserChangedEvent(event),
            );
      },
    );

    on<HomePageChangeEvent>(
        (event, emit) => emit(state.copyWith(page: event.page)));
  }
  myUserChangedEvent(UserModel myProfile) {
    emit(state.copyWith(myProfile: myProfile, status: HomeStatus.loaded));
  }
}
