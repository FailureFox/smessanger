import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chat_status.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_event.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_state.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/repositories/messages_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final MessagesRepository messageRepo;
  final UserRepository userRepo;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final ChatModel chatModel;
  ChatBloc(
      {required this.chatModel,
      required this.messageRepo,
      required this.userRepo})
      : super(ChatState()) {
    on<ChatLoadingEvent>((event, emit) {
      emit(state.copyWith(status: ChatStatus.loading));
      try {
        userRepo.getUser(chatModel.chatUser).listen((user) {
          userLoaded(user);
          messageRepo.getMessages(chatModel.chatID).listen((messages) {
            messagesLoaded(messages);
          });
        });
      } on SocketException catch (e) {
        log('asd' + e.message);
      }
    });

    on<ChatSendMessageEvent>((event, emit) async {
      messageRepo.sendMessage(
          message: MessageModel(
              dateTime: Timestamp.now(),
              from: event.uid,
              message: event.message,
              readed: false),
          chatId: chatModel.chatID);
    });
  }

  userLoaded(UserModel user) {
    emit(state.copyWith(chatUser: user));
  }

  messagesLoaded(List<MessageModel> messages) {
    final time = messages.last.dateTime.toDate();
    final lastMessageTime = timeDetect(time);
    if (state.messages == null) {
      emit(
        state.copyWith(
          messages: messages,
          status: ChatStatus.loaded,
          lastMessageTime: lastMessageTime,
        ),
      );
    } else {
      listKey.currentState!
          .insertItem(0, duration: const Duration(milliseconds: 200));
      state.messages = messages;
    }
  }

  String timeDetect(DateTime time) {
    final difference = DateTime.now().difference(time);

    if (difference.inDays != 0) {
      if (difference.inDays > 7) {
        return '${time.day}.${time.month}.${time.year}';
      } else {
        return '${time.weekday}';
      }
    } else if (difference.inHours != 0) {
      return '${time.hour}:${time.minute} ${time.timeZoneName}';
    } else if (difference.inMinutes != 0) {
      return difference.inMinutes.toString() + ' m';
    } else {
      return difference.inSeconds.toString() + ' s';
    }
  }
}
