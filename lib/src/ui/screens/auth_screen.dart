import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc_export.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/ui/pages/auth_pages/welcome_page.dart';
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
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.read<AuthBloc>().pageController,
        children: const [
          WelcomePage(),
          NumberInputPage(),
          PhoneVerifyPage(),
        ],
      ),
    );
  }
}

class AuthAppbar extends StatelessWidget {
  const AuthAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
          onPressed: () => context.read<AuthBloc>().add(AuthBackPageEvent()),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          )),
    );
  }
}
