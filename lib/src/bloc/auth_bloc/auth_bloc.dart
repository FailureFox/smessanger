import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_event.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_state.dart';
import 'package:smessanger/src/resources/data/countries_data.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PageController pageController;

  AuthBloc({required this.pageController})
      : super(AuthNumberInputState(countries: Countries.countryList)) {
    on<AuthWelcomeNextEvent>((event, emit) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn);
      final countries = Countries.countryList;
      emit(AuthNumberInputState(countries: countries));
    });

    on<AuthBackPageEvent>((event, emit) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn);
      if (pageController.page == 1) {
        emit(AuthWelcomeState());
      }
    });
    on<AuthNumberChangeEvent>((event, emit) => emit(
        (state as AuthNumberInputState).copyWith(phoneNumber: event.number)));

    on<AuthInputNextEvent>((event, emit) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn);
    });

    on<AuthVerifyNextEvent>((event, emit) => pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn));
  }
}
