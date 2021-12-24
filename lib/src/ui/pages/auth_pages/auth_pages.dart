import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_event.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          _Texts.welcomeLogo,
          style: Theme.of(context).textTheme.headline1,
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.width / 8,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                context.read<AuthBloc>().add(AuthNextPageEvent());
              },
              child: const Text(_Texts.welcomeButtonText)),
        )
      ],
    );
  }
}

class _Texts {
  //welcome
  static const String welcomeLogo = 'Pure.';
  static const String welcomeButtonText = 'Continue with phone';
}
