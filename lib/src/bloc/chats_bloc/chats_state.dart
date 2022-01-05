import 'package:smessanger/src/bloc/chats_bloc/chat_status.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/models/user_model.dart';

class ChatState {
  final UserModel? chatUser;
  final List<MessageModel>? messages;
  final ChatStatus status;
  ChatState({this.chatUser, this.messages, this.status = ChatStatus.initial});

  ChatState copyWith({
    List<MessageModel>? messages,
    UserModel? user,
    ChatStatus? status,
  }) {
    return ChatState(
      chatUser: user,
      messages: messages,
      status: status ?? this.status,
    );
  }
}
