import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_bloc.dart';
import 'package:smessanger/src/ui/pages/register_pages/name_input_page.dart';
import 'package:smessanger/src/ui/pages/register_pages/photo_upload_page.dart';
import 'package:smessanger/src/ui/pages/register_pages/pin_setup_page.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => RegistrationBloc(), child: const _RegistrationScreen());
  }
}

class _RegistrationScreen extends StatefulWidget {
  const _RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<_RegistrationScreen> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              if (controller.page! > 0) {
                controller.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
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
        controller: controller,
        children: const [NameInputPage(), PhotoUploadPage(), PinSetupPage()],
      ),
    );
  }
}
