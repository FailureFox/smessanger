import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
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
      final CountriesModel? selectedCountry,
      final List<CountriesModel>? countries,
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
  final CountriesModel selectedCountry;

  AuthPhoneVerifyState({
    required this.phoneNumber,
    required this.selectedCountry,
    this.myVerifyCode = '',
    this.status = AuthStatus.initial,
  });

  AuthPhoneVerifyState copyWith({String? myVerifyCode, AuthStatus? status}) {
    return AuthPhoneVerifyState(
      phoneNumber: phoneNumber,
      myVerifyCode: myVerifyCode ?? this.myVerifyCode,
      status: status ?? this.status,
      selectedCountry: selectedCountry,
    );
  }
}

class AuthUserInitialSetupState extends AuthState {
  final String name;
  final String surname;
  final String countryCode;
  final String phoneNumber;
  final String? avatar;
  AuthUserInitialSetupState({
    required this.countryCode,
    required this.phoneNumber,
    this.name = '',
    this.surname = '',
    this.avatar = '',
  });

  AuthUserInitialSetupState copyWIth({
    String? name,
    String? surname,
    String? avatar,
  }) {
    return AuthUserInitialSetupState(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      avatar: avatar ?? this.avatar,
    );
  }
}
