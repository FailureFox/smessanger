abstract class RegistrationEvent {}

class RegNameChangeEvent extends RegistrationEvent {
  final String name;
  RegNameChangeEvent({required this.name});
}

class RegSurnameChangeEVent extends RegistrationEvent {
  final String surname;
  RegSurnameChangeEVent({required this.surname});
}

class RegAvatarSelectEvent extends RegistrationEvent {}

class RegPinCodeChangeEvent extends RegistrationEvent {
  final String pinCode;
  RegPinCodeChangeEvent({required this.pinCode});
}

class RegRolesSelectEvent {}
