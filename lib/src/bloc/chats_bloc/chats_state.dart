import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';

class ChatState {}

class ChatStateLoaded extends ChatState {
  final UserModel chatUser;
  final List<Message> messages;
  final String lastMessageTime;
  ChatStateLoaded({
    required this.chatUser,
    required this.messages,
    this.lastMessageTime = '',
  });
  ChatStateLoaded copyWith({
    UserModel? chatUser,
    List<Message>? messages,
    String? lastMessageTime,
  }) {
    return ChatStateLoaded(
        chatUser: chatUser ?? this.chatUser,
        messages: messages ?? this.messages,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime);
  }
}

class ChatStateLoading extends ChatState {}

class ChatStateError extends ChatState {
  String errorText;
  ChatStateError({required this.errorText});
}
