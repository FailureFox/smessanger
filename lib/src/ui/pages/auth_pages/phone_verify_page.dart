import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';

class PhoneVerifyPage extends StatelessWidget {
  const PhoneVerifyPage({Key? key}) : super(key: key);

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
          const Text(
            _Texts.verifySubtitle +
                ' +998-(90)-022-26-61\n' +
                _Texts.verifySubtitle2 +
                ' 57 sec',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          PinCodeTextField(
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
                selectedFillColor:
                    Theme.of(context).inputDecorationTheme.fillColor,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 55,
                fieldWidth: 50,
              ),
              enableActiveFill: true,
              appContext: context,
              length: 6,
              onChanged: (value) {}),
          const Spacer(),
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 8,
              child: ElevatedButton(
                  onPressed: () =>
                      context.read<AuthBloc>().add(AuthVerifyNextEvent()),
                  child: const Text(_Texts.buttonNext)))
        ],
      ),
    );
  }
}

class _Texts {
  //phone verify
  static const String verifyTitle = 'Enter sign in code';
  static const String verifySubtitle = 'We just sent it to';
  static const String verifySubtitle2 = "Haven't received? Wait for";
  static const String buttonNext = 'Next';
}
