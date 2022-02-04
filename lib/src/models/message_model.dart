import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Message {
  final Timestamp dateTime;
  final String from;
  final bool readed;
  Message({required this.dateTime, required this.from, required this.readed});
  Map<String, dynamic> toMap();
}

class MessageTextModel extends Message {
  final String message;

  MessageTextModel({
    required dateTime,
    required from,
    required this.message,
    required readed,
  }) : super(dateTime: dateTime, from: from, readed: readed);

  factory MessageTextModel.fromMap(Map<String, dynamic> map) {
    return MessageTextModel(
      dateTime: map['dateTime'],
      from: map['from'],
      message: map['message'],
      readed: map['readed'],
    );
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'dateTime': Timestamp.now(),
      'from': from,
      'message': message,
      'readed': false,
    };
  }
}

class MessageMediaModel extends Message {
  final List<String> mediaUrl;
  final MediaType mediaType;
  final String? message;
  MessageMediaModel({
    required this.mediaUrl,
    required this.mediaType,
    required Timestamp dateTime,
    required String from,
    required bool readed,
    this.message,
  }) : super(dateTime: dateTime, from: from, readed: readed);

  @override
  Map<String, dynamic> toMap() {
    return {
      'mediaUrl': mediaUrl,
      'mediaType': mediaType.name,
      'dateTime': Timestamp.now(),
      'from': from,
      'message': message,
      'readed': false,
    };
  }

  factory MessageMediaModel.fromMap(Map<String, dynamic> map) {
    return MessageMediaModel(
      mediaUrl: map['mediaUrl'],
      mediaType: map['mediaType'],
      dateTime: map['dateTime'],
      from: map['from'],
      readed: map['readed'],
      message: map['message'],
    );
  }
  static const Map<String, dynamic> mediaTypes = {
    'video': MediaType.video,
    'image': MediaType.image,
    'music': MediaType.music,
  };
}

enum MediaType { image, video, music }
