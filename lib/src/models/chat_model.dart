class ChatModel {
  ChatType type;
  String chatUser;
  String chatID;

  ChatModel({
    required this.type,
    required this.chatUser,
    required this.chatID,
  });
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatID: map['chatID'],
      chatUser: map['chatUser'],
      type: _typeDetect[map['chatType']]!,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'chatID': chatID,
      'chatUser': chatUser,
      'type': type.toString(),
    };
  }

  static const Map<String, ChatType> _typeDetect = {
    'oneToOne': ChatType.oneToOne,
    'group': ChatType.group,
    'channel': ChatType.channel,
  };
}

enum ChatType { oneToOne, channel, group }
