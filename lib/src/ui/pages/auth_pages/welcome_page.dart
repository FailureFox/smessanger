import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc_export.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_event.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            actions: const [LightDarkIconButton()],
          ),
          const Spacer(),
          Text(
            _Texts.welcomeLogo,
            style: Theme.of(context).textTheme.headline1,
          ),
          const Spacer(),
          SizedBox(
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
      ),
    );
  }
}

class _Texts {
  //welcome
  static const String welcomeLogo = 'Pure.';
  static const String welcomeButtonText = 'Continue with phone';
}

class LightDarkIconButton extends StatefulWidget {
  const LightDarkIconButton({Key? key}) : super(key: key);

  @override
  LightDarkIconButtonState createState() => LightDarkIconButtonState();
}

class LightDarkIconButtonState extends State<LightDarkIconButton> {
  changeTheme() {
    context.read<AppBloc>().add(AppThemeChangeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return AnimatedCrossFade(
          firstChild: IconButton(
              splashRadius: 25,
              onPressed: changeTheme,
              icon: const Icon(
                Icons.dark_mode,
                color: Colors.white,
              )),
          secondChild: IconButton(
              splashRadius: 25,
              onPressed: changeTheme,
              icon: const Icon(
                Icons.light_mode,
                color: Colors.black,
              )),
          crossFadeState: state.isDark
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 200));
    });
  }
}
