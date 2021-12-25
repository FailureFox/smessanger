import 'package:smessanger/src/models/chat_model.dart';

class MyProfile {
  String name;
  String? surname;
  String phoneNumber;
  String countryCode;
  String? status;
  String? avatarUrl;
  List<ChatModel> chats;

  MyProfile({
    required this.name,
    this.surname,
    required this.countryCode,
    this.status,
    required this.avatarUrl,
    this.chats = const [],
    required this.phoneNumber,
  });

  factory MyProfile.fromMap(Map<String, dynamic> map) {
    return MyProfile(
      name: map['name'],
      surname: map['surname'] != '' ? map['surname'] : null,
      countryCode: map['countryCode'],
      status: map['status'] != '' ? map['status'] : null,
      avatarUrl: map['avatarUrl'] != '' ? map['avatarUrl'] : null,
      chats: (map['chats'] as List<Map<String, dynamic>>)
          .map((e) => ChatModel.fromMap(e))
          .toList(),
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname ?? '',
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'status': status ?? '',
      'avatarUrl': avatarUrl ?? '',
      'chats': chats.map((e) => e.toMap()).toList()
    };
  }
}
