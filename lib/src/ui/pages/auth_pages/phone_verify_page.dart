import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';

class PhoneVerifyPage extends StatefulWidget {
  const PhoneVerifyPage({Key? key}) : super(key: key);

  @override
  State<PhoneVerifyPage> createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthVerifyPageLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_Texts.verifyTitle,
              style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 5),
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            final mystate = state;
            if (mystate is AuthPhoneVerifyState) {
              return Text(
                _Texts.verifySubtitle +
                    mystate.phoneNumber +
                    '\n' +
                    _Texts.verifySubtitle2 +
                    ' 57 sec',
                style: const TextStyle(fontSize: 16),
              );
            } else {
              return const SizedBox();
            }
          }),
          const SizedBox(height: 20),
          const SmsPinField(),
          const Spacer(),
          const PhoneVerifyButton(),
        ],
      ),
    );
  }
}

class PhoneVerifyButton extends StatelessWidget {
  const PhoneVerifyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.width / 8,
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        final mystate = state;
        if (mystate is AuthPhoneVerifyState) {
          return ElevatedButton(
            onPressed: mystate.status == AuthStatus.loading
                ? null
                : () => context.read<AuthBloc>().add(AuthSmsVerifyEvent()),
            child: const Text(_Texts.buttonNext),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class SmsPinField extends StatelessWidget {
  const SmsPinField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
        keyboardType: TextInputType.number,
        textStyle: Theme.of(context).textTheme.headline1,
        backgroundColor: Colors.transparent,
        showCursor: false,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          activeColor: Colors.transparent,
          disabledColor: Colors.transparent,
          selectedColor: Colors.transparent,
          inactiveColor: Colors.transparent,
          activeFillColor: Theme.of(context)
              .inputDecorationTheme
              .fillColor!
              .withOpacity(0.7),
          inactiveFillColor: Theme.of(context)
              .inputDecorationTheme
              .fillColor!
              .withOpacity(0.7),
          selectedFillColor: Theme.of(context).inputDecorationTheme.fillColor,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: MediaQuery.of(context).size.width / 8,
          fieldWidth: MediaQuery.of(context).size.width / 8,
        ),
        enableActiveFill: true,
        appContext: context,
        length: 6,
        onChanged: (value) {
          context.read<AuthBloc>().add(AuthSmsChangeEvent(sms: value));
        });
  }
}

class _Texts {
  //phone verify
  static const String verifyTitle = 'Enter sign in code';
  static const String verifySubtitle = 'We just sent it to ';
  static const String verifySubtitle2 = "Haven't received? Wait for";
  static const String buttonNext = 'Next';
}
