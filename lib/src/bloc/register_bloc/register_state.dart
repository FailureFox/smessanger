import 'package:smessanger/src/bloc/register_bloc/register_status.dart';
import 'package:smessanger/src/models/roles.dart';

class RegistrationState {
  final String name;
  final String surname;
  final String uid;
  final String avatarUrl;
  final String pinCode;
  final Set<Roles> roles;
  final RegistrationStatus status;
  final List<String> interestedNews;

  RegistrationState({
    this.name = '',
    this.surname = '',
    this.status = const RegistrationInitialStatus(),
    this.avatarUrl = '',
    this.pinCode = '',
    this.uid = '',
    this.roles = const {},
    this.interestedNews = const [],
  });

  RegistrationState copyWith(
      {String? name,
      String? surname,
      String? avatarUrl,
      Set<Roles>? roles,
      RegistrationStatus? status,
      String? pinCode,
      String? uid,
      List<String>? interestedNews}) {
    return RegistrationState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      pinCode: pinCode ?? this.pinCode,
      roles: roles ?? this.roles,
      status: status ?? this.status,
      uid: uid ?? this.uid,
      interestedNews: interestedNews ?? this.interestedNews,
    );
  }
}
