import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';

class NumberInputPage extends StatelessWidget {
  const NumberInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_Texts.phoneTitle, style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 5),
          const Text(_Texts.phoneSubtitle),
          const SizedBox(height: 20),
          const NumberInputField(),
          const SizedBox(height: 20),
          const Text(_Texts.phonePrivacyText),
          const Spacer(),
          const NumberNextButton()
        ],
      ),
    );
  }
}

class NumberInputField extends StatelessWidget {
  const NumberInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
          inputFormatters: [MaskTextInputFormatter(mask: '##-###-##-####')],
          keyboardType: TextInputType.phone,
          onChanged: (value) => context
              .read<AuthBloc>()
              .add(AuthNumberChangeEvent(number: value)),
          decoration: InputDecoration(
              prefixIcon: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            height: 100,
                          ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  margin: const EdgeInsets.only(left: 15, right: 2),
                  child: Row(
                    children: [
                      SizedBox(
                          height: 15,
                          child: Image.asset('assets/flags/ad.png')),
                      const SizedBox(width: 10),
                      Text(
                        '+998',
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
              ),
              hintText: 'Phone number')),
    );
  }
}

class NumberNextButton extends StatelessWidget {
  const NumberNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 8,
      width: double.infinity,
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return ElevatedButton(
          child: const Text('Next'),
          onPressed:
              (state is AuthNumberInputState ? state : AuthNumberInputState())
                          .phoneNumber !=
                      ''
                  ? () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      context.read<AuthBloc>().add(AuthInputNextEvent());
                    }
                  : null,
        );
      }),
    );
  }
}

class _Texts {
  //phone input
  static const String phoneSubtitle = "We'll send you a sign-in code";
  static const String phoneTitle = "What's your phone?";
  static const String phonePrivacyText =
      "By entering your number. you're agreeing to our Terms Of Sevice and Privacy Policy";
}
