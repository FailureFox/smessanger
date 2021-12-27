import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';
import 'package:smessanger/src/resources/data/countries_data.dart';

class AuthState {
  final bool darkTheme;
  final String phoneNumber;
  final UniversalStatus status;
  final CountriesModel selectedCountry;
  final String myVerifyCode;

  AuthState({
    this.phoneNumber = '',
    this.status = UniversalStatus.initial,
    this.darkTheme = false,
    this.myVerifyCode = '',
    this.selectedCountry = const CountriesModel(
      name: 'uz',
      dialCode: '+998',
      flag: 'assets/flags/uz.png',
    ),
  });
  AuthState copyWith(
      {bool? darkTheme,
      String? phoneNumber,
      UniversalStatus? status,
      CountriesModel? selectedCountry,
      String? myVerifyCode}) {
    return AuthState(
      darkTheme: darkTheme ?? this.darkTheme,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }
}
