import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/resources/domain/repositories/messages_repository.dart';

class MessagesRepositoryUse extends MessagesRepository {
  final FirebaseFirestore firestore;
  MessagesRepositoryUse({required this.firestore});

  @override
  Future<void> sendMessage({
    required MessageModel message,
    required String chatId,
  }) async {
    final CollectionReference collection =
        firestore.collection('chats').doc(chatId).collection('messages');
    await collection.add(message.toMap());
  }

  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
    final snapshots = firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .snapshots();
    return snapshots.map((event) =>
        event.docs.map((e) => MessageModel.fromMap(e.data())).toList());
  }
}
