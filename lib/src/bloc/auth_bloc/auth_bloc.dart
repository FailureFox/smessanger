import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_event.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_state.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';
import 'package:smessanger/src/resources/domain/repositories/auth_repository.dart';

import 'package:smessanger/src/resources/domain/repositories/token_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PageController pageController = PageController();
  final AuthRepository repository;
  final TokenRepository tokenRepository;
  String myUID = '';
  //bloc
  AuthBloc({required this.repository, required this.tokenRepository})
      : super(AuthState()) {
    //
    on<AuthNextPageEvent>((event, emit) => nextPage());
    on<AuthBackPageEvent>((event, emit) => backPage());

    //number
    on<AuthNumberChangeEvent>(
      (event, emit) => emit((state).copyWith(phoneNumber: event.number)),
    );

    on<AuthCountrySelectEvent>(
        (event, emit) => emit(state.copyWith(selectedCountry: event.country)));
    on<AuthNumberVerifyEvent>(
      (event, emit) {
        try {
          emit((state).copyWith(status: AuthLoadingStatus()));
          repository.verificationNumber(
            phoneNumber: state.selectedCountry.dialCode +
                state.phoneNumber.replaceAll('-', ''),
            controller: pageController,
            context: event.context,
          );
        } catch (e) {
          emit(state.copyWith(status: AuthErrorStatus(error: e.toString())));
        }
      },
    );
    on<AuthErrorEvent>((event, emit) =>
        emit(state.copyWith(status: AuthErrorStatus(error: event.message))));
    on<AuthCountrySearchInputEvent>(
        (event, emit) => emit(state.copyWith(countrySearch: event.search)));
    //sms-pin
    on<AuthSmsChangeEvent>((event, emit) {
      if (event.sms.length > 5) {
        emit((state).copyWith(
            myVerifyCode: event.sms, status: const AuthInitialStatus()));
      }
    });

    on<AuthSmsVerifyEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: AuthLoadingStatus()));
        myUID = await repository.signInWithNumber(state.myVerifyCode);
        final bool isRegistered = await repository.isRegistered(myUID);
        if (isRegistered) {
          emit(state.copyWith(status: AuthLoginStatus(uid: myUID)));
          tokenRepository.saveToken(myUID);
        } else {
          emit(state.copyWith(status: AuthRegistrationStatus(uid: myUID)));
        }
      } catch (e) {
        emit((state).copyWith(status: AuthErrorStatus(error: e.toString())));
      }
    });
  }
  //func
  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void backPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }
}
