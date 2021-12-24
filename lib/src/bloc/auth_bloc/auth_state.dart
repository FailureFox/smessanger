import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';
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
  final CountriesModel selectedCountry;
  final AuthStatus status;
  AuthNumberInputState({
    this.phoneNumber = '',
    this.status = AuthStatus.initial,
    this.selectedCountry = const CountriesModel(
        dialCode: '+998', flag: 'assets/flags/uz.png', name: 'uz'),
  });

  AuthNumberInputState copyWith(
      {String? phoneNumber,
      CountriesModel? selectedCountry,
      List<CountriesModel>? countries,
      AuthStatus? status}) {
    return AuthNumberInputState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      status: status ?? this.status,
    );
  }
}

class AuthPhoneVerifyState extends AuthState {
  final String phoneNumber;
  final String myVerifyCode;
  final AuthStatus status;

  AuthPhoneVerifyState({
    required this.phoneNumber,
    this.myVerifyCode = '',
    this.status = AuthStatus.initial,
  });

  AuthPhoneVerifyState copyWith({String? myVerifyCode, AuthStatus? status}) {
    return AuthPhoneVerifyState(
      phoneNumber: phoneNumber,
      myVerifyCode: myVerifyCode ?? this.myVerifyCode,
      status: status ?? this.status,
    );
  }
}
