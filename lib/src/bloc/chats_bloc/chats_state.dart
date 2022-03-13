import 'package:smessanger/src/models/chat_model.dart';

class ChatState {}

class ChatStateLoaded extends ChatState {
  final List<ChatModel> chats;
  ChatStateLoaded({required this.chats});
  ChatStateLoaded copyWith({List<ChatModel>? chats}) {
    return ChatStateLoaded(chats: chats ?? this.chats);
  }
}

class ChatStateLoading extends ChatState {}

class ChatStateError extends ChatState {
  String errorText;
  ChatStateError({required this.errorText});
}
