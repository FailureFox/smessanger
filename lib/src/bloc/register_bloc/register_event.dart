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

class PinCodeChangeEvent extends RegistrationEvent {
  final String pinCode;
  PinCodeChangeEvent({required this.pinCode});
}

class RolesSelectEvent {}
