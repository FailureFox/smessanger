import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_event.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_state.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';
import 'package:smessanger/src/resources/data/firebase_remote_use.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PageController pageController;
  final FireBaseRemoteUse firebase = FireBaseRemoteUse();
  String myUID = '';
  //bloc
  AuthBloc({required this.pageController}) : super(AuthState()) {
    on<AuthNextPageEvent>((event, emit) => nextPage());
    on<AuthBackPageEvent>((event, emit) => backPage());

    //number
    on<AuthNumberChangeEvent>(
      (event, emit) => emit((state).copyWith(phoneNumber: event.number)),
    );

    on<AuthNumberVerifyEvent>(
      (event, emit) {
        try {
          emit((state).copyWith(status: UniversalStatus.loading));

          firebase.verificationNumber(
            phoneNumber: state.selectedCountry.dialCode +
                state.phoneNumber.replaceAll('-', ''),
            controller: pageController,
          );
        } on SocketException {
          emit(state.copyWith(status: UniversalStatus.error));
        } catch (e) {
          emit(state.copyWith(status: UniversalStatus.error));
        }
      },
    );

    //sms-pin
    on<AuthSmsChangeEvent>((event, emit) {
      if (event.sms.length > 5) {
        emit((state).copyWith(
            myVerifyCode: event.sms, status: UniversalStatus.initial));
      }
    });

    on<AuthSmsVerifyEvent>((event, emit) async {
      try {
        emit((state).copyWith(status: UniversalStatus.loading));
        myUID = await firebase.signInWithNumber((state).myVerifyCode);
      } catch (e) {
        emit((state).copyWith(status: UniversalStatus.error));
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
