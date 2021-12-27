import 'package:flutter/material.dart';
import 'package:smessanger/src/ui/pages/register_pages/name_input_page.dart';
import 'package:smessanger/src/ui/pages/register_pages/photo_upload_page.dart';
import 'package:smessanger/src/ui/pages/register_pages/pin_setup_page.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        children: const [NameInputPage(), PhotoUploadPage(), PinSetupPage()],
      ),
    );
  }
}
