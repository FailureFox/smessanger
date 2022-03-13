import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:smessanger/src/models/my_profile_model.dart';

class ChatModel {
  final ChatType type;
  final UserModel chatUser;
  final String? lastMessage;
  final Timestamp lastMessageTime;
  final String chatId;
  late final String time;
  final int notReadedCount;
  ChatModel({
    required this.type,
    required this.chatUser,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.chatId,
    required this.notReadedCount,
  }) {
    time = timeDetect(lastMessageTime.toDate());
  }
  factory ChatModel.fromMap({
    required Map<String, dynamic> map,
    required UserModel user,
    required String chatId,
    required int notReadedCount,
  }) {
    return ChatModel(
      lastMessage: map['message'],
      lastMessageTime: map['dateTime'],
      type: _typeDetect[map['type']]!,
      chatUser: user,
      chatId: chatId,
      notReadedCount: notReadedCount,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'chatUser': chatUser.uid,
      'type': type.name,
    };
  }

  static const Map<String, ChatType> _typeDetect = {
    'oneToOne': ChatType.oneToOne,
    'group': ChatType.group,
    'channel': ChatType.channel,
  };

  ChatModel copyWith({
    ChatType? type,
    UserModel? chatUser,
    String? lastMessage,
    Timestamp? lastMessageTime,
    String? chatId,
    int? notReadedCount,
  }) {
    return ChatModel(
      type: type ?? this.type,
      chatId: chatId ?? this.chatId,
      chatUser: chatUser ?? this.chatUser,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      notReadedCount: notReadedCount ?? this.notReadedCount,
    );
  }

  String timeDetect(DateTime time) {
    final difference = DateTime.now().difference(time);

    if (difference.inDays != 0) {
      if (difference.inDays > 7) {
        return '${time.day}.${time.month}.${time.year}';
      } else {
        final timeFromWeek = DateFormat('EEE').format(time);
        return timeFromWeek;
      }
    } else if (difference.inHours != 0) {
      return '${time.hour}:${time.minute} ${time.timeZoneName}';
    } else if (difference.inMinutes != 0) {
      return difference.inMinutes.toString() + ' m';
    } else {
      return difference.inSeconds.toString() + ' s';
    }
  }
}

enum ChatType { oneToOne, channel, group }
