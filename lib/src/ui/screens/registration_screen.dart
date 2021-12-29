import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/injections.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';
import 'package:smessanger/src/ui/pages/register_pages/intro_page.dart';
import 'package:smessanger/src/ui/pages/register_pages/name_input_page.dart';
import 'package:smessanger/src/ui/pages/register_pages/photo_upload_page.dart';
import 'package:smessanger/src/ui/pages/register_pages/pin_setup_page.dart';
import 'package:smessanger/src/ui/pages/register_pages/roles_select_page.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen(
      {Key? key, required this.country, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;
  final String country;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
        create: (_) => sl.call<RegistrationBloc>(),
        child: const _RegistrationScreen());
  }
}

class _RegistrationScreen extends StatefulWidget {
  const _RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<_RegistrationScreen> {
  @override
  void initState() {
    super.initState();
    final uid = context.read<AppBloc>().state.uid;
    context.read<RegistrationBloc>().add(RegUIDLoadingEvent(uid: uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.read<RegistrationBloc>().controller,
        children: const [
          NameInputPage(),
          PhotoUploadPage(),
          PinSetupPage(),
          RolesSelectPage(),
          IntroPage(),
        ],
      ),
    );
  }
}
