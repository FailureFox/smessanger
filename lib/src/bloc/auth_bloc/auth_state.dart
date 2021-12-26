import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';
import 'package:smessanger/src/resources/data/countries_data.dart';

abstract class AuthState {
  final String phoneNumber;
  final AuthStatus status;
  final CountriesModel selectedCountry;

  AuthState({
    this.phoneNumber = '',
    this.status = AuthStatus.initial,
    this.selectedCountry = const CountriesModel(
        name: 'uz', dialCode: '+998', flag: 'assets/flags/uz.png'),
  });
}

class AuthWelcomeState extends AuthState {
  final bool darkTheme;
  AuthWelcomeState({this.darkTheme = false}) : super();
  AuthWelcomeState copyWith({bool? darkTheme}) {
    return AuthWelcomeState(darkTheme: darkTheme ?? this.darkTheme);
  }
}

class AuthNumberInputState extends AuthState {
  AuthNumberInputState({
    String phoneNumber = '',
    AuthStatus status = AuthStatus.initial,
    CountriesModel selectedCountry = const CountriesModel(
        dialCode: '+998', flag: 'assets/flags/uz.png', name: 'uz'),
  }) : super(
          phoneNumber: phoneNumber,
          status: status,
          selectedCountry: selectedCountry,
        );

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
  final String myVerifyCode;

  AuthPhoneVerifyState({
    required String phoneNumber,
    required CountriesModel selectedCountry,
    this.myVerifyCode = '',
    AuthStatus status = AuthStatus.initial,
  }) : super(
          phoneNumber: phoneNumber,
          selectedCountry: selectedCountry,
          status: status,
        );

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
  final String? avatar;
  final String avatarDownloadUrl;

  AuthUserInitialSetupState({
    required this.countryCode,
    required String phoneNumber,
    this.name = '',
    this.surname = '',
    this.avatar = '',
    this.avatarDownloadUrl = '',
    AuthStatus status = AuthStatus.initial,
  }) : super(phoneNumber: phoneNumber, status: status);

  AuthUserInitialSetupState copyWIth({
    String? name,
    String? surname,
    String? avatar,
    AuthStatus? status,
    String? avatarDownloadUrl,
  }) {
    return AuthUserInitialSetupState(
        countryCode: countryCode,
        phoneNumber: phoneNumber,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        avatar: avatar ?? this.avatar,
        status: status ?? this.status,
        avatarDownloadUrl: avatarDownloadUrl ?? this.avatarDownloadUrl);
  }
}
