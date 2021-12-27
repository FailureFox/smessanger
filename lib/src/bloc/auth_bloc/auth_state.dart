import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';
import 'package:smessanger/src/resources/data/countries_data.dart';

class AuthState {
  final bool darkTheme;
  final String phoneNumber;
  final AuthStatus status;
  final CountriesModel selectedCountry;
  final String myVerifyCode;

  final String countrySearch;

  AuthState({
    this.phoneNumber = '',
    this.status = const AuthInitialStatus(),
    this.darkTheme = false,
    this.myVerifyCode = '',
    this.selectedCountry = const CountriesModel(
      name: 'uz',
      dialCode: '+998',
      flag: 'assets/flags/uz.png',
    ),
    this.countrySearch = '',
  });

  AuthState copyWith({
    bool? darkTheme,
    String? phoneNumber,
    AuthStatus? status,
    CountriesModel? selectedCountry,
    String? myVerifyCode,
    String? countrySearch,
  }) {
    return AuthState(
      darkTheme: darkTheme ?? this.darkTheme,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      countrySearch: countrySearch ?? this.countrySearch,
    );
  }
}
