import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/injections.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';
import 'package:smessanger/src/ui/pages/register_pages/name_input_page.dart';
import 'package:smessanger/src/ui/pages/register_pages/photo_upload_page.dart';
import 'package:smessanger/src/ui/pages/register_pages/pin_setup_page.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

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
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              if (context.read<RegistrationBloc>().controller.page! > 0) {
                context.read<RegistrationBloc>().pervousePage();
              } else {
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).iconTheme.color,
            )),
      ),
      body: PageView(
        controller: context.read<RegistrationBloc>().controller,
        children: const [NameInputPage(), PhotoUploadPage(), PinSetupPage()],
      ),
    );
  }
}
