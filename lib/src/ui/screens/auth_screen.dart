import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc_export.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';
import 'package:smessanger/src/ui/pages/auth_pages/welcome_page.dart';
import 'package:smessanger/src/ui/pages/auth_pages/number_input_page.dart';
import 'package:smessanger/src/ui/pages/auth_pages/phone_verify_page.dart';
import 'package:smessanger/src/ui/screens/registration_screen.dart';
import 'package:smessanger/injections.dart' as rep;

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => rep.sl.call<AuthBloc>(),
      child: const _AuthScreen(),
    );
  }
}

class _AuthScreen extends StatelessWidget {
  const _AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final authStatus = state.status;
          if (authStatus is AuthErrorStatus) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(authStatus.error.split('.')[0]),
            ));
            context
                .read<AuthBloc>()
                .emit(state.copyWith(status: const AuthInitialStatus()));
          } else if (authStatus is AuthLoginStatus) {
            context
                .read<AppBloc>()
                .add(AppTokenLoadingEvent(uid: authStatus.uid));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Scaffold()));
          } else if (authStatus is AuthRegistrationStatus) {
            context
                .read<AuthBloc>()
                .emit(state.copyWith(status: const AuthInitialStatus()));
            context
                .read<AppBloc>()
                .add(AppTokenLoadingEvent(uid: authStatus.uid));

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegistrationScreen(
                          phoneNumber: state.phoneNumber,
                          country:
                              state.selectedCountry.aplhaCode.toLowerCase(),
                        )));
          }
        },
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: context.read<AuthBloc>().pageController,
          children: const [
            WelcomePage(),
            NumberInputPage(),
            PhoneVerifyPage(),
          ],
        ),
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
