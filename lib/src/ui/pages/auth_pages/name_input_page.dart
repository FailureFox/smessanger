import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';

class NameInputPage extends StatefulWidget {
  const NameInputPage({Key? key}) : super(key: key);

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthInitialUserSetupLoading());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_Texts.title, style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 5),
          const Text(_Texts.subtitle),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(isDense: false, hintText: 'First name'),
          ),
          const SizedBox(height: 10),
          const TextField(
            decoration:
                InputDecoration(isDense: false, hintText: 'Second name'),
          ),
          const Spacer(),
          const NameNexButton()
        ],
      ),
    );
  }
}

class NameNexButton extends StatelessWidget {
  const NameNexButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.width / 8,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Next'),
      ),
    );
  }
}

class _Texts {
  static const String title = "What's your name?";
  static const String subtitle = "People use real names on Pure.";
}
