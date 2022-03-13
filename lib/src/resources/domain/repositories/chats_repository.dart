import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

abstract class ChatsRepository {
  Stream<QuerySnapshot> listenChats(String uid);
  Future<List<ChatModel>> getChats(String uid, UserRepository userRepo);
  Future<void> deleteChat(
      {required String chatId,
      required String myId,
      required String companionId});
  Future<int> getisNotReadedCount(String myId, String chatId);
}
