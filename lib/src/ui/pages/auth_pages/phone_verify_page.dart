import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';
import 'package:smessanger/src/ui/screens/auth_screen.dart';

class PhoneVerifyPage extends StatelessWidget {
  const PhoneVerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthAppbar(),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_Texts.verifyTitle,
                  style: Theme.of(context).textTheme.headline1),
              const SizedBox(height: 5),
              Text(
                _Texts.verifySubtitle +
                    context.read<AuthBloc>().state.phoneNumber +
                    '\n' +
                    _Texts.verifySubtitle2 +
                    ' 57 sec',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              const SmsPinField(),
              const Spacer(),
              const PhoneVerifyButton(),
            ],
          ),
        ))
      ],
    );
  }
}

class PhoneVerifyButton extends StatelessWidget {
  const PhoneVerifyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 15,
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status is AuthLoadingStatus
              ? null
              : () => context.read<AuthBloc>().add(AuthSmsVerifyEvent()),
          child: const Text(_Texts.buttonNext),
        );
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
