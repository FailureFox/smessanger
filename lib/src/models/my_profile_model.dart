import 'package:smessanger/src/models/chat_model.dart';

class MyProfile {
  String name;
  String? surname;
  String phoneNumber;
  String countryCode;
  String? status;
  String? avatarUrl;
  String uid;
  List<String> roles;
  List<String> newsChannels;
  List<ChatModel> chats;

  MyProfile({
    required this.name,
    this.surname,
    required this.countryCode,
    required this.uid,
    this.roles = const [],
    this.status,
    required this.avatarUrl,
    this.chats = const [],
    required this.phoneNumber,
    required this.newsChannels,
  });

  factory MyProfile.fromMap(Map<String, dynamic> map, String uid) {
    return MyProfile(
      name: map['name'],
      uid: uid,
      surname: map['surname'] != '' ? map['surname'] : null,
      countryCode: map['countryCode'],
      status: map['status'] != '' ? map['status'] : null,
      avatarUrl: map['avatarUrl'] != '' ? map['avatarUrl'] : null,
      chats: (map['chats'] as List)
          .map((e) => ChatModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      phoneNumber: map['phoneNumber'],
      roles: (map['roles'] as List<dynamic>).map((e) => e as String).toList(),
      newsChannels: (map['newsChannels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
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
      'roles': roles,
      'newsChannels': newsChannels,
      'chats': chats.map((e) => e.toMap()).toList()
    };
  }
}
