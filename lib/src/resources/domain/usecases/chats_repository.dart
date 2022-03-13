import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/resources/domain/repositories/chats_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

class ChatsRepositoryUse extends ChatsRepository {
  final FirebaseFirestore firestore;
  ChatsRepositoryUse({required this.firestore});

  @override
  Future<List<ChatModel>> getChats(String uid, UserRepository userRepo) async {
    try {
      final path = await firestore
          .collection('chats')
          .doc(uid)
          .collection('chats')
          .get();
      final List<ChatModel> chats = [];
      for (var item in path.docs) {
        final user = await userRepo.getAsyncUser(item['chatUser']);
        final int notReadedCount = await getisNotReadedCount(uid, item.id);
        chats.add(ChatModel.fromMap(
          map: item.data(),
          user: user,
          chatId: item.id,
          notReadedCount: notReadedCount,
        ));
      }
      return chats;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<QuerySnapshot> listenChats(String uid) {
    final path =
        firestore.collection('chats').doc(uid).collection('chats').snapshots();
    return path;
  }

  @override
  Future<int> getisNotReadedCount(String myId, String chatId) async {
    try {
      final count = await firestore
          .collection('chats')
          .doc(myId)
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('readed')
          .startAt([false]).endAt([false]).get();
      return count.docs.length;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteChat(
      {required String chatId,
      required String myId,
      required String companionId}) async {
    try {
      await firestore
          .collection('chats')
          .doc(companionId)
          .collection('chats')
          .doc(chatId)
          .delete();
      await firestore
          .collection('chats')
          .doc(myId)
          .collection('chats')
          .doc(chatId)
          .delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
