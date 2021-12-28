import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';

class NameInputPage extends StatelessWidget {
  const NameInputPage({Key? key}) : super(key: key);

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
          const NameInputField(),
          const SizedBox(height: 10),
          const SurnameInputField(),
          const Spacer(),
          const NameNextButton()
        ],
      ),
    );
  }
}

class NameInputField extends StatelessWidget {
  const NameInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) =>
          context.read<RegistrationBloc>().add(RegNameChangeEvent(name: value)),
      decoration: const InputDecoration(isDense: false, hintText: 'First name'),
    );
  }
}

class SurnameInputField extends StatelessWidget {
  const SurnameInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context
          .read<RegistrationBloc>()
          .add(RegSurnameChangeEvent(surname: value)),
      decoration:
          const InputDecoration(isDense: false, hintText: 'Second name'),
    );
  }
}

class NameNextButton extends StatelessWidget {
  const NameNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.width / 8,
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          context.read<RegistrationBloc>().nextPage();
        },
        child: const Text('Next'),
      ),
    );
  }
}

class _Texts {
  static const String title = "What's your name?";
  static const String subtitle = "People use real names on Pure.";
}
