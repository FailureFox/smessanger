import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/resources/domain/usecases/search_person.dart';

import 'person_search_state.dart';

class PersonSearchBloc extends Cubit<PersonSearchState> {
  final SearchPerson searchPerson;
  PersonSearchBloc({required this.searchPerson})
      : super(const PersonSearchInitialState());

  personSearchFromNumber({required String number}) async {
    try {
      emit(PersonSearchLoadingState());
      final persons =
          await searchPerson.searchPersonFromNumber(phoneNumber: number);
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
