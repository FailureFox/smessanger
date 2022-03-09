import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

abstract class ChatsRepository {
  Future<void> sendMessage(
      {required MessageTextModel message,
      required String? chatId,
      required String companionId,
      required String myId});
  Stream<QuerySnapshot> listenChats(String uid);
  Future<List<ChatModel>> getChats(String uid, UserRepository userRepo);

  Future<List<Message>> getMessages(
      {required String chatId, required String uid});

  Stream<QuerySnapshot> listenMessages(
      {required String chatId, required String uid});
}
