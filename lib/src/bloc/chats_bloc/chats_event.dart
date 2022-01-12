abstract class ChatEvent {}

class ChatLoadingEvent extends ChatEvent {}

class ChatSendMessageEvent extends ChatEvent {
  String message;
  String uid;
  ChatSendMessageEvent({required this.message, required this.uid});
}
