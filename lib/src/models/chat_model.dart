class ChatModel {
  ChatType type;
  String userId;
  String chatId;

  ChatModel({
    required this.type,
    required this.userId,
    required this.chatId,
  });
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'],
      userId: map['user'],
      type: _typeDetect[map['chatType']]!,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'userId': userId,
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
