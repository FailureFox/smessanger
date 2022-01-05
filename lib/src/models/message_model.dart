import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  Timestamp dateTime;
  String from;
  String message;
  bool readed;

  MessageModel({
    required this.dateTime,
    required this.from,
    required this.message,
    required this.readed,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      dateTime: map['dateTime'],
      from: map['from'],
      message: map['message'],
      readed: map['readed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'from': from,
      'message': message,
      'readed': readed,
    };
  }
}
