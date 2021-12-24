import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';

abstract class AuthEvent {}

//Next page events

class AuthNextPageEvent extends AuthEvent {}

class AuthBackPageEvent extends AuthEvent {}

//Page loading Events
class AuthWelcomePageLoadingEvent extends AuthEvent {}

class AuthNumPageLoadingEvent extends AuthEvent {}

class AuthVerifyPageLoadingEvent extends AuthEvent {}

class AuthNameInputLoadingEvent extends AuthEvent {}

//Other beautiful events :)

//number-input
class AuthNumberVerifyEvent extends AuthEvent {}

class AuthNumberChangeEvent extends AuthEvent {
  final String number;
  AuthNumberChangeEvent({required this.number});
}
//sms pin input

class AuthSmsVerifyEvent extends AuthEvent {
  AuthSmsVerifyEvent();
}

class AuthSmsChangeEvent extends AuthEvent {
  final String sms;
  AuthSmsChangeEvent({required this.sms});
}
