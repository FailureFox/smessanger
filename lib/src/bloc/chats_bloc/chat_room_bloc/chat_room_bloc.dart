import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chat_room_bloc/chat_room_state.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/resources/domain/repositories/chats_repository.dart';

class ChatRoomBloc extends Cubit<ChatRoomState> {
  final String? chatId;
  final String uid;
  late StreamSubscription subscription;
  final ChatsRepository chatRep;
  bool isFirst = true;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  ChatRoomBloc({
    required this.chatId,
    required this.chatRep,
    required this.uid,
  }) : super(const ChatRoomStateInitial()) {
    chatRoomLoading();
  }
  @override
  close() async {
    subscription.cancel();
    super.close();
  }

  chatRoomLoading() async {
    if (chatId != null) {
      subscription = chatRep.listenMessages(chatId: chatId!, uid: uid).listen(
        (event) async {
          final List<DocumentChange> docs = event.docChanges;
          for (var item in docs) {
            if (isFirst) {
              isFirst = false;
              break;
            } else {
              final myState = state as ChatRoomStateLoaded;
              switch (item.type) {
                case DocumentChangeType.added:
                  final messages = messageAdd(item.doc, myState.messages);
                  emit(ChatRoomStateLoaded(messages: messages));
                  break;
                case DocumentChangeType.modified:
                  final messages = messageEdit(item.doc, myState.messages);
                  emit(ChatRoomStateLoaded(messages: messages));
                  break;
                case DocumentChangeType.removed:
                  final messages = messageDelete(item.doc, myState.messages);
                  emit(ChatRoomStateLoaded(messages: messages));
                  break;
              }
            }
          }
        },
      );
      emit(ChatRoomStateLoading());

      final messages = await chatRep.getMessages(chatId: chatId!, uid: uid);
      emit(ChatRoomStateLoaded(messages: messages));
    }
  }

  sendMessage({
    required String companionId,
    required String message,
  }) async {
    try {
      final messageModel = MessageTextModel(
          dateTime: Timestamp.now(),
          from: uid,
          message: message,
          readed: false);
      await chatRep.sendMessage(
        message: messageModel,
        chatId: chatId,
        companionId: companionId,
        myId: uid,
      );
    } catch (e) {
      print(e);
    }
  }

  messageEdit(DocumentSnapshot snap, List<Message> messages) {
    final message =
        MessageTextModel.fromMap(snap.data() as Map<String, dynamic>, snap.id);
    for (var i = 0; i < messages.length; i++) {
      if (messages[i].id == snap.id) {
        messages.removeAt(i);
        messages.insert(
          i,
          message,
        );
        break;
      }
    }
    return messages;
  }

  messageDelete(DocumentSnapshot snap, List<Message> messages) {
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].id == snap.id) {
        listKey.currentState!.removeItem(i, (context, animaton) {
          return Container();
        });
      }
    }
    for (var item in messages) {
      if (item.id == snap.id) {
        messages.remove(item);
        break;
      }
    }
    return messages;
  }

  messageAdd(DocumentSnapshot snap, List<Message> messages) {
    final MessageTextModel message =
        MessageTextModel.fromMap(snap.data() as Map<String, dynamic>, snap.id);
    listKey.currentState!.insertItem(0);
    messages.insert(0, message);
    return messages;
  }
}
