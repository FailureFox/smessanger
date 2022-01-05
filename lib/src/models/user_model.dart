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
      phoneNumber: map['phoneNumber'],
      roles: (map['roles'] as List).map((e) => e as String).toList(),
      newsChannels:
          (map['newsChannels'] as List).map((e) => e as String).toList(),
      groups: (map['groups'] as List).map((e) => e as String).toList(),
      following: (map['following'] as List).map((e) => e as String).toList(),
      followers: (map['followers'] as List).map((e) => e as String).toList(),
    );
  }
}
