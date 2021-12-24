import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc_export.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/ui/pages/auth_pages/welcome_page.dart';
import 'package:smessanger/src/ui/pages/auth_pages/name_input_page.dart';
import 'package:smessanger/src/ui/pages/auth_pages/number_input_page.dart';
import 'package:smessanger/src/ui/pages/auth_pages/phone_verify_page.dart';
import 'package:smessanger/src/ui/styles/colors.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(pageController: PageController(initialPage: 0)),
      child: const _AuthScreen(),
    );
  }
}

class _AuthScreen extends StatelessWidget {
  const _AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          actions:
              state is AuthWelcomeState ? [const LightDarkIconButton()] : [],
          elevation: 0,
          leading: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return state is! AuthWelcomeState
                ? IconButton(
                    splashRadius: 25,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      context.read<AuthBloc>().add(AuthBackPageEvent());
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.dbackgroundHL,
                    ),
                  )
                : const SizedBox();
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: context.read<AuthBloc>().pageController,
            children: const [
              WelcomePage(),
              NumberInputPage(),
              PhoneVerifyPage(),
              NameInputPage()
            ],
          ),
        ),
      );
    });
  }
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
