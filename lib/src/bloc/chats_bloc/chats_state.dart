import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/models/user_model.dart';

class ChatState {
  final UserModel? chatUser;
  final List<MessageModel>? messages;
  ChatState({this.chatUser, this.messages});

  ChatState copyWith({List<MessageModel>? messages, UserModel? user}) {
    return ChatState(chatUser: user, messages: messages);
  }
}
