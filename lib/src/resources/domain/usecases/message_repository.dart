import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/resources/domain/repositories/message_repository.dart';

class MessageRepositoryUse extends MessageRepository {
  final FirebaseFirestore firestore;
  MessageRepositoryUse({required this.firestore});
  @override
  Future<String?> sendMessage({
    required MessageTextModel message,
    required String? chatId,
    required String companionId,
    required String myId,
  }) async {
    try {
      final bool isNotCreated = chatId == null;
      Map<String, dynamic> myMap = message.toMap();
      final CollectionReference collection = firestore.collection('chats');
      final myPath = collection.doc(myId).collection('chats').doc(chatId);
      final sended = await myPath.collection('messages').add(message.toMap());
      isNotCreated ? chatId = (await myPath.get()).id : chatId;
      final cPath = collection.doc(companionId).collection('chats').doc(chatId);
      await cPath.collection('messages').doc(sended.id).set(message.toMap());
      myMap.addAll(
          {'chatUser': companionId, 'type': 'oneToOne', 'id': myPath.id});
      await myPath.set(myMap);
      myMap['chatUser'] = myId;
      await cPath.set(myMap);
      if (isNotCreated) {
        return chatId;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Message>> getMessages(
      {required String chatId, required String uid}) async {
    final path = firestore.collection('chats').doc(uid).collection('chats');
    final snapshots = path.doc(chatId).collection('messages');
    final map =
        (await snapshots.orderBy('dateTime', descending: true).get()).docs;
    return map.map((e) => MessageTextModel.fromMap(e.data(), e.id)).toList();
  }

  @override
  Stream<QuerySnapshot> listenMessages(
      {required String chatId, required String uid}) {
    final path = firestore.collection('chats').doc(uid).collection('chats');
    final snapshots = path.doc(chatId).collection('messages');
    return snapshots.snapshots();
  }
}
