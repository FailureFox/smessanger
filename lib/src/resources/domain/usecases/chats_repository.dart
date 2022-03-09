import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/resources/domain/repositories/chats_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';

class ChatsRepositoryUse extends ChatsRepository {
  final FirebaseFirestore firestore;
  ChatsRepositoryUse({required this.firestore});

  @override
  Future<List<ChatModel>> getChats(String uid, UserRepository userRepo) async {
    final path =
        await firestore.collection('chats').doc(uid).collection('chats').get();
    final List<ChatModel> chats = [];
    for (var item in path.docs) {
      final user = await userRepo.getAsyncUser(item['chatUser']);
      chats.add(ChatModel.fromMap(item.data(), user, item.id));
    }
    return chats;
  }

  @override
  Stream<QuerySnapshot> listenChats(String uid) {
    final path =
        firestore.collection('chats').doc(uid).collection('chats').snapshots();
    return path;
  }

  @override
  Future<void> sendMessage({
    required MessageTextModel message,
    required String? chatId,
    required String companionId,
    required String myId,
  }) async {
    try {
      Map<String, dynamic> myMap = message.toMap();
      final CollectionReference collection = firestore.collection('chats');
      final myPath = collection.doc(myId).collection('chats').doc(chatId);
      final cPath = collection.doc(companionId).collection('chats').doc(chatId);
      final sended = await myPath.collection('messages').add(message.toMap());
      await cPath.collection('messages').doc(sended.id).set(message.toMap());
      myMap.addAll(
          {'chatUser': companionId, 'type': 'oneToOne', 'id': myPath.id});
      await myPath.set(myMap);
      myMap['chatUser'] = myId;
      await cPath.set(myMap);
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
