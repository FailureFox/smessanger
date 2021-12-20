abstract class AuthEvent {}

class AuthBackPageEvent extends AuthEvent {}

class AuthNumberChangeEvent extends AuthEvent {
  final String number;
  AuthNumberChangeEvent({required this.number});
}

//Next page events
class AuthWelcomeNextEvent extends AuthEvent {}

class AuthInputNextEvent extends AuthEvent {}

class AuthVerifyNextEvent extends AuthEvent {}
