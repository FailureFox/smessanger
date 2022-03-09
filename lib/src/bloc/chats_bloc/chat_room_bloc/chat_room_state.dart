import 'package:smessanger/src/models/message_model.dart';

abstract class ChatRoomState {
  const ChatRoomState();
}

class ChatRoomStateLoaded extends ChatRoomState {
  List<Message> messages;
  ChatRoomStateLoaded({this.messages = const []});
}

class ChatRoomStateInitial extends ChatRoomState {
  const ChatRoomStateInitial();
}

class ChatRoomStateLoading extends ChatRoomState {}
