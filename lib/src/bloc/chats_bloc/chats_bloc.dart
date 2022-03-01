import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_state.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/repositories/messages_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

class ChatBloc extends Cubit<ChatState> {
  final MessagesRepository messageRepo;
  final UserRepository userRepo;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final ChatModel chatModel;
  ChatBloc(
      {required this.chatModel,
      required this.messageRepo,
      required this.userRepo})
      : super(ChatState()) {
    chatLoading();
  }

  chatLoading() async {
    emit(ChatStateLoading());
    final user = await userRepo.getUser(chatModel.chatUser).first;
    messageRepo.getMessages(chatModel.chatID).listen((event) {
      messagesLoaded(event, user);
    });
  }

  sendMessage({required String text, required String from}) {
    messageRepo.sendMessage(
      message: MessageTextModel(
        dateTime: Timestamp.now(),
        from: from,
        message: text,
        readed: false,
      ),
      chatId: chatModel.chatID,
    );
  }

  messagesLoaded(List<Message> messages, UserModel user) {
    final time = messages.last.dateTime.toDate();
    final lastMessageTime = timeDetect(time);

    try {
      if (state is ChatStateLoading) {
        emit(ChatStateLoaded(
          messages: messages,
          
          lastMessageTime: lastMessageTime,
          chatUser: user,
        ));
      } else if (state is ChatStateLoaded) {
        final mystate = state as ChatStateLoaded;
        listKey.currentState!
            .insertItem(0, duration: const Duration(milliseconds: 200));
        emit(mystate.copyWith(messages: messages));
      }
    } catch (e) {
      print(e.toString());
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
