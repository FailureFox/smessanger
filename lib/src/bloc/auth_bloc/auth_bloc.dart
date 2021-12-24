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
  //bloc
  AuthBloc({required this.pageController}) : super(AuthNumberInputState()) {
    on<AuthNextPageEvent>((event, emit) => nextPage);
    on<AuthBackPageEvent>((event, emit) => backPage);
//number
    on<AuthNumPageLoadingEvent>((event, emit) => emit(AuthNumberInputState()));
    on<AuthNumberChangeEvent>(
      (event, emit) => emit(
        (state as AuthNumberInputState).copyWith(phoneNumber: event.number),
      ),
    );
    on<AuthNumberVerifyEvent>(
      (event, emit) {
        try {
          final myState = state as AuthNumberInputState;
          emit((state as AuthNumberInputState)
              .copyWith(status: AuthStatus.loading));

          firebase.verificationNumber(
            phoneNumber: myState.selectedCountry.dialCode +
                myState.phoneNumber.replaceAll('-', ''),
            controller: pageController,
          );
        } catch (e) {
          print(e);
        }
      },
    );

//sms-pin
    on<AuthVerifyPageLoadingEvent>((event, emit) {
      final myState = state as AuthNumberInputState;
      emit(AuthPhoneVerifyState(phoneNumber: myState.phoneNumber));
    });
    on<AuthSmsVerifyEvent>((event, emit) async {
      try {
        await firebase
            .signInWithNumber((state as AuthPhoneVerifyState).myVerifyCode);
        nextPage();
      } catch (e) {
        print(e);
      }
    });
    on<AuthSmsChangeEvent>((event, emit) {
      emit((state as AuthPhoneVerifyState).copyWith(myVerifyCode: event.sms));
    });
    //name
  }
  //func
  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void backPage() {
    pageController.previousPage(
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }
}
