import 'package:smessanger/src/bloc/chats_bloc/chat_status.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';

class ChatState {
  final UserModel? chatUser;
  List<MessageModel>? messages;
  final ChatStatus status;
  final String lastMessageTime;
  ChatState({
    this.chatUser,
    this.messages,
    this.status = ChatStatus.initial,
    this.lastMessageTime = '',
  });

  ChatState copyWith({
    List<MessageModel>? messages,
    UserModel? chatUser,
    ChatStatus? status,
    String? lastMessageTime,
  }) {
    return ChatState(
      chatUser: chatUser ?? this.chatUser,
      messages: messages ?? this.messages,
      status: status ?? this.status,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }
}
