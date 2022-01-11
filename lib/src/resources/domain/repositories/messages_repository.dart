import 'package:smessanger/src/models/message_model.dart';

abstract class MessagesRepository {
  Future<void> sendMessage(
      {required MessageModel message, required String chatId});

  Stream<List<MessageModel>> getMessages(String chatId);
}
