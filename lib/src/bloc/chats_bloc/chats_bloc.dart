import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chat_status.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_event.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_state.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/models/user_model.dart';
import 'package:smessanger/src/resources/domain/repositories/firebase_repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FireBaseRepository repository;
  final ChatModel chatModel;
  ChatBloc({required this.chatModel, required this.repository})
      : super(ChatState()) {
    on<ChatLoadingEvent>((event, emit) {
      try {
        repository.getChatUser(chatModel.chatUser).listen((user) {
          userLoaded(user);
        });
      } on SocketException catch (e) {
        log(e.message);
      }
      try {
        repository.getMessages(chatModel.chatID).listen((messages) {
          messagesLoaded(messages);
        });
      } on SocketException catch (e) {
        log(e.message);
      }
    });
  }

  
  userLoaded(UserModel user) {
    emit(state.copyWith(
      user: user,
      status: state.messages != null ? ChatStatus.loaded : ChatStatus.loading,
    ));
  }

  messagesLoaded(List<MessageModel> messages) {
    emit(state.copyWith(
        messages: messages,
        status:
            state.chatUser != null ? ChatStatus.loaded : ChatStatus.loading));
  }
}