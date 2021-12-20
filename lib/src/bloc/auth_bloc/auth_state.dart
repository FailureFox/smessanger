import 'package:smessanger/src/resources/data/countries_data.dart';

abstract class AuthState {}

class AuthWelcomeState extends AuthState {
  final bool darkTheme;
  AuthWelcomeState({this.darkTheme = false});
  AuthWelcomeState copyWith({bool? darkTheme}) {
    return AuthWelcomeState(darkTheme: darkTheme ?? this.darkTheme);
  }
}

class AuthNumberInputState extends AuthState {
  final String phoneNumber;
  final String verifyCode;
  final CountriesModel? selectedCountry;
  final List<CountriesModel> countries;

  AuthNumberInputState({
    this.phoneNumber = '',
    this.verifyCode = '',
    this.selectedCountry,
    this.countries = const [],
  });

  AuthNumberInputState copyWith(
      {String? phoneNumber,
      String? verifyCode,
      CountriesModel? selectedCountry,
      List<CountriesModel>? countries}) {
    return AuthNumberInputState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verifyCode: verifyCode ?? this.verifyCode,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      countries: countries ?? this.countries,
    );
  }
}

class AuthPhoneVerifyState extends AuthState {
  final String phoneNumber;
  final String verifyCode;
  final String myVerifyCode;

  AuthPhoneVerifyState(
      {required this.phoneNumber,
      required this.verifyCode,
      this.myVerifyCode = ''});

  AuthPhoneVerifyState copyWith({String? myVerifyCode}) {
    return AuthPhoneVerifyState(
      phoneNumber: phoneNumber,
      verifyCode: verifyCode,
      myVerifyCode: myVerifyCode ?? this.myVerifyCode,
    );
  }
}
