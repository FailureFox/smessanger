import 'package:smessanger/src/models/roles.dart';

abstract class RegistrationEvent {}

class RegUIDLoadingEvent extends RegistrationEvent {
  final String uid;
  RegUIDLoadingEvent({required this.uid});
}

class RegNameChangeEvent extends RegistrationEvent {
  final String name;
  RegNameChangeEvent({required this.name});
}

class RegSurnameChangeEvent extends RegistrationEvent {
  final String surname;
  RegSurnameChangeEvent({required this.surname});
}

class RegAvatarSelectEvent extends RegistrationEvent {}

class RegPinCodeChangeEvent extends RegistrationEvent {
  final String pinCode;
  RegPinCodeChangeEvent({required this.pinCode});
}

class RegRoleSelectEvent extends RegistrationEvent {
  final Roles role;
  RegRoleSelectEvent({required this.role});
}

class RegRoleDeleteEvent extends RegistrationEvent {
  final Roles role;
  RegRoleDeleteEvent({required this.role});
}
