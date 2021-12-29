import 'package:smessanger/src/bloc/register_bloc/register_status.dart';
import 'package:smessanger/src/models/roles.dart';

class RegistrationState {
  final String name;
  final String surname;
  final String uid;
  final String avatarUrl;
  final String pinCode;
  final String phoneNumber;
  final String country;
  final List<Roles> roles;
  final RegistrationStatus status;
  final List<String> interestedNews;

  RegistrationState({
    this.name = '',
    this.surname = '',
    this.status = const RegistrationInitialStatus(),
    this.avatarUrl = '',
    this.pinCode = '',
    this.uid = '',
    this.phoneNumber = '',
    this.country = '',
    this.roles = const [],
    this.interestedNews = const [],
  });

  RegistrationState copyWith(
      {String? name,
      String? surname,
      String? avatarUrl,
      List<Roles>? roles,
      RegistrationStatus? status,
      String? pinCode,
      String? uid,
      String? phoneNumber,
      String? country,
      List<String>? interestedNews}) {
    return RegistrationState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      pinCode: pinCode ?? this.pinCode,
      roles: roles ?? this.roles,
      status: status ?? this.status,
      uid: uid ?? this.uid,
      country: country ?? this.country,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      interestedNews: interestedNews ?? this.interestedNews,
    );
  }
}
