abstract class AuthEvent {}

//next page events

class AuthNextPageEvent extends AuthEvent {}

class AuthBackPageEvent extends AuthEvent {}

class AuthWelcomePageLoadingEvent extends AuthEvent {}

//other beautiful events :)

//number-input
class AuthNumPageLoadingEvent extends AuthEvent {}

class AuthNumberVerifyEvent extends AuthEvent {}

class AuthNumberChangeEvent extends AuthEvent {
  final String number;
  AuthNumberChangeEvent({required this.number});
}

//sms pin input
class AuthVerifyPageLoadingEvent extends AuthEvent {}

class AuthSmsVerifyEvent extends AuthEvent {
  AuthSmsVerifyEvent();
}

class AuthSmsChangeEvent extends AuthEvent {
  final String sms;
  AuthSmsChangeEvent({required this.sms});
}

//userInitialSetup

class AuthInitialUserSetupLoading extends AuthEvent {}

class AuthNameChangeEvent extends AuthEvent {
  final String name;
  AuthNameChangeEvent({required this.name});
}

class AuthSurnameChangeEvent extends AuthEvent {
  final String surname;
  AuthSurnameChangeEvent({required this.surname});
}

class AuthNameSurnameSetEvent extends AuthEvent {}
