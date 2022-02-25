import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';
import 'package:smessanger/src/resources/domain/usecases/user_repository_use.dart';

import 'person_search_state.dart';

class PersonSearchBloc extends Cubit<PersonSearchState> {
  final UserRepository searchPerson;
  PersonSearchBloc({required this.searchPerson})
      : super(const PersonSearchInitialState());

  personSearchFromNumber({required String text}) async {
    try {
      emit(PersonSearchLoadingState());
      final persons = await searchPerson.searchUser(
          text: text, searchType: UsersSearchType.phoneNumber);
      if (persons.isNotEmpty) {
        emit(PersonSearchLoaded(users: persons));
      } else {
        emit(PersonSearchEmpty());
      }
    } catch (e) {
      emit(PersonSearchErrorState(error: e.toString()));
    }
  }
}
