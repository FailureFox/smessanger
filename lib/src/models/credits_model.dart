import 'dart:convert';

class CreditsModel {
  final bool adult;
  final Gender gender;
  final int id;
  final String knowForDepartament;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;
  CreditsModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knowForDepartament,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory CreditsModel.fromMap(Map<String, dynamic> map) {
    final int gender = map['gender']?.toInt();
    return CreditsModel(
      adult: map['adult'] ?? false,
      gender: _genderDetect[gender] ?? Gender.invalid,
      id: map['id']?.toInt() ?? 0,
      knowForDepartament: map['know_for_departament'] ?? '',
      name: map['name'] ?? '',
      originalName: map['original_name'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      profilePath: map['profile_path'] ?? '',
      castId: map['cast_id']?.toInt() ?? 0,
      character: map['character'] ?? '',
      creditId: map['credit_id'] ?? '',
      order: map['order']?.toInt() ?? 0,
    );
  }
  static const Map<int, Gender> _genderDetect = {
    1: Gender.female,
    2: Gender.male,
    0: Gender.invalid
  };

  factory CreditsModel.fromJson(String source) =>
      CreditsModel.fromMap(json.decode(source));
}

enum Gender { male, female, invalid }
