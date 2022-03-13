import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smessanger/src/models/message_model.dart';

abstract class MessageRepository {
  Future<String?> sendMessage(
      {required MessageTextModel message,
      required String? chatId,
      required String companionId,
      required String myId});
  Future<List<Message>> getMessages(
      {required String chatId, required String uid});

  Stream<QuerySnapshot> listenMessages(
      {required String chatId, required String uid});
}
