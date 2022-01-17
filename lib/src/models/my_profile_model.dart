import 'package:smessanger/src/models/chat_model.dart';

class UserModel {
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
  List<String> groups;
  List<String> following;
  List<String> followers;

  UserModel({
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
    this.groups = const [],
    this.following = const [],
    this.followers = const [],
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
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
      roles: (map['roles'] as List).map((e) => e as String).toList(),
      newsChannels:
          (map['newsChannels'] as List).map((e) => e as String).toList(),
      groups: (map['groups'] as List).map((e) => e as String).toList(),
      following: (map['following'] as List).map((e) => e as String).toList(),
      followers: (map['followers'] as List).map((e) => e as String).toList(),
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
      'chats': chats.map((e) => e.toMap()).toList(),
      'groups': groups,
      'following': following,
      'followers': followers,
    };
  }
}
