import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';
import 'package:smessanger/src/resources/domain/usecases/user_repository_use.dart';

import 'person_search_state.dart';

class PersonSearchBloc extends Cubit<PersonSearchState> {
  final UserRepository searchPerson;
  final List<ChatModel> chats;
  PersonSearchBloc({required this.searchPerson, required this.chats})
      : super(const PersonSearchInitialState());

  personSearchFromNumber({required String text}) async {
    try {
      emit(PersonSearchLoadingState());
      List<UserModel> persons = await searchPerson.searchUser(
          text: text, searchType: UsersSearchType.phoneNumber);
      if (persons.isNotEmpty) {
        List<UserModel> localPerson = [];
        for (int i = 0; i < persons.length; i++) {
          for (int p = 0; p < chats.length; p++) {
            if (persons[i].uid == chats[p].chatUser) {
              localPerson.add(persons.removeAt(i));
            }
          }
        }
        emit(PersonSearchLoaded(users: persons, localUsers: localPerson));
      } else {
        emit(PersonSearchEmpty());
      }
    } catch (e) {
      print(e);
      emit(PersonSearchErrorState(error: e.toString()));
    }
  }
}
