import 'dart:convert';

class TrailersModel {
  final String site;
  final String name;
  final String type;
  final String key;
  TrailersModel({
    required this.site,
    required this.name,
    required this.type,
    required this.key,
  });

  factory TrailersModel.fromMap(Map<String, dynamic> map) {
    return TrailersModel(
      site: map['site'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      key: map['key'] ?? '',
    );
  }

  factory TrailersModel.fromJson(String source) =>
      TrailersModel.fromMap(json.decode(source));
}
