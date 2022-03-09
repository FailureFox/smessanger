import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_state.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/repositories/chats_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

class ChatBloc extends Cubit<ChatState> {
  final ChatsRepository messageRepo;
  final UserRepository userRepo;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final String uid;
  ChatBloc(
      {required this.messageRepo, required this.userRepo, required this.uid})
      : super(ChatState());

  chatsLoading() async {
    messageRepo.listenChats(uid).listen(
      (snapShot) async {
        for (var i in snapShot.docChanges) {
          if (state is! ChatStateLoaded) {
            break;
          }
          final String userId =
              (i.doc.data() as Map<String, dynamic>)['chatUser'];
          final UserModel chatUser = await userRepo.getAsyncUser(userId);
          final ChatModel singleChat = ChatModel.fromMap(
              i.doc.data() as Map<String, dynamic>, chatUser, i.doc.id);
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
    final List<ChatModel> chats = await messageRepo.getChats(uid, userRepo);
    emit(ChatStateLoaded(chats: chats));
  }

//chatsMethods
  chatItemChanged(ChatModel modifiedChat) {
    final myState = state;
    if (myState is ChatStateLoaded) {
      final chats = myState.chats;
      for (var p = 0; p < chats.length; p++) {
        if (modifiedChat.chatId == chats[p].chatId) {
          chats.removeAt(p);
          chats.add(modifiedChat);
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

      for (var item in myChats) {
        if (item.chatId == deletedChat.chatId) {
          myChats.remove(deletedChat);
        }
      }
      emit(myState.copyWith(chats: myChats));
    }
  }
}

enum ChatChangeType { modified, deleted, added }






