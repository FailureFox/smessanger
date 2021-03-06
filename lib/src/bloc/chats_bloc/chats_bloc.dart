import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_state.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/repositories/chats_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

class ChatBloc extends Cubit<ChatState> {
  final ChatsRepository chatRep;
  final UserRepository userRepo;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final String uid;
  bool isFirst = true;
  ChatBloc({required this.chatRep, required this.userRepo, required this.uid})
      : super(ChatState()) {
    chatsLoading();
  }

  chatsLoading() async {
    chatRep.listenChats(uid).listen(
      (snapShot) async {
        for (var i in snapShot.docChanges) {
          if (isFirst) {
            isFirst = false;
            break;
          }
          final String userId =
              (i.doc.data() as Map<String, dynamic>)['chatUser'];
          final UserModel chatUser = await userRepo.getAsyncUser(userId);
          final int notReadedCount =
              await chatRep.getisNotReadedCount(uid, i.doc.id);
          final ChatModel singleChat = ChatModel.fromMap(
            map: i.doc.data() as Map<String, dynamic>,
            user: chatUser,
            chatId: i.doc.id,
            notReadedCount: notReadedCount,
          );
          switch (i.type) {
            case DocumentChangeType.added:
              chatItemAdded(singleChat);
              break;
            case DocumentChangeType.modified:
              chatItemChanged(singleChat);
              break;
            case DocumentChangeType.removed:
              chatItemDeleted(singleChat);
              break;
          }
        }
      },
    );
    emit(ChatStateLoading());
    final List<ChatModel> chats = await chatRep.getChats(uid, userRepo);
    emit(ChatStateLoaded(chats: chats));
  }

  deleteChat(
      {required String chatId,
      required String companionId,
      required String myID}) async {
    try {
      chatRep.deleteChat(chatId: chatId, myId: myID, companionId: companionId);
    } catch (e) {}
  }

//chatsMethods
  chatItemChanged(ChatModel modifiedChat) {
    final myState = state;
    if (myState is ChatStateLoaded) {
      final chats = myState.chats;
      for (var p = 0; p < chats.length; p++) {
        if (modifiedChat.chatId == chats[p].chatId) {
          chats.removeAt(p);
          chats.insert(0, modifiedChat);
          break;
        }
      }
      emit(myState.copyWith(chats: chats));
    }
  }

  chatItemAdded(ChatModel newChat) {
    final myState = state;
    if (myState is ChatStateLoaded) {
      final myChats = myState.chats;
      myChats.add(newChat);
      emit(myState.copyWith(chats: myChats));
    }
  }

  chatItemDeleted(ChatModel deletedChat) {
    final myState = state;
    if (myState is ChatStateLoaded) {
      final myChats = myState.chats;

      for (var i = 0; i < myChats.length; i++) {
        if (deletedChat.chatId == myChats[i].chatId) {
          myChats.removeAt(i);
        }
      }

      emit(myState.copyWith(chats: myChats));
    }
  }
}

enum ChatChangeType { modified, deleted, added }
