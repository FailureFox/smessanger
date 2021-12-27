import 'package:smessanger/src/models/roles.dart';

class RegistrationState {
  final String name;
  final String surname;
  final String avatarUrl;
  final String pinCode;
  final Set<Roles> roles;
  final List<String> interestedNews;

  RegistrationState({
    this.name = '',
    this.surname = '',
    this.avatarUrl = '',
    this.pinCode = '',
    this.roles = const {},
    this.interestedNews = const [],
  });

  RegistrationState copyWith(
      {String? name,
      String? surname,
      String? avatarUrl,
      Set<Roles>? roles,
      String? pinCode,
      List<String>? interestedNews}) {
    return RegistrationState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      pinCode: pinCode ?? this.pinCode,
      roles: roles ?? this.roles,
      interestedNews: interestedNews ?? this.interestedNews,
    );
  }
}
