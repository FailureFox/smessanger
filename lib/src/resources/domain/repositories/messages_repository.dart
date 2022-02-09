import 'package:smessanger/src/models/message_model.dart';

abstract class MessagesRepository {
  Future<void> sendMessage(
      {required MessageTextModel message, required String chatId});

  Stream<List<Message>> getMessages(String chatId);
}
