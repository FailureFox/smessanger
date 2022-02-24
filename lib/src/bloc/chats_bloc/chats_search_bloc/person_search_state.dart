import 'package:smessanger/src/models/my_profile_model.dart';

abstract class PersonSearchState {
  const PersonSearchState();
}

class PersonSearchLoadingState extends PersonSearchState {}

class PersonSearchInitialState extends PersonSearchState {
  const PersonSearchInitialState();
}

class PersonSearchErrorState extends PersonSearchState {
  final String error;
  PersonSearchErrorState({required this.error});
}

class PersonSearchLoaded extends PersonSearchState {
  List<UserModel> users;
  PersonSearchLoaded({required this.users});
}

class PersonSearchEmpty extends PersonSearchState {}
