import 'package:flutter/cupertino.dart';
import 'package:smessanger/src/resources/data/countries_data.dart';

abstract class AuthEvent {}

//next page events

class AuthNextPageEvent extends AuthEvent {}

class AuthBackPageEvent extends AuthEvent {}

//other beautiful events :)

//number-input

class AuthNumberVerifyEvent extends AuthEvent {
  final BuildContext context;
  AuthNumberVerifyEvent({required this.context});
}

class AuthNumberChangeEvent extends AuthEvent {
  final String number;
  AuthNumberChangeEvent({required this.number});
}

class AuthCountrySelectEvent extends AuthEvent {
  final CountriesModel country;
  AuthCountrySelectEvent(this.country);
}

class AuthErrorEvent extends AuthEvent {
  String message;
  AuthErrorEvent({required this.message});
}

class AuthCountrySearchInputEvent extends AuthEvent {
  final String search;
  AuthCountrySearchInputEvent({required this.search});
}
//sms pin input

class AuthSmsVerifyEvent extends AuthEvent {
  AuthSmsVerifyEvent();
}

class AuthSmsChangeEvent extends AuthEvent {
  final String sms;
  AuthSmsChangeEvent({required this.sms});
}
