import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Container(
        height: MediaQuery.of(context).size.height / 2.1,
        width: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            const Spacer(flex: 3),
            CircleAvatar(
              radius: MediaQuery.of(context).size.width / 8,
              backgroundImage: NetworkImage(state.myProfile!.avatarUrl!),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  '${state.myProfile!.name} ${state.myProfile!.surname}',
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 5),
                const Text('last seen 4 min ago'),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const MyProfileIndicators(count: '1,156', text: 'followers'),
                  VerticalDivider(width: 0, color: Theme.of(context).hintColor),
                  const MyProfileIndicators(count: '112', text: 'following'),
                  VerticalDivider(width: 0, color: Theme.of(context).hintColor),
                  const MyProfileIndicators(count: '25', text: 'groups'),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      );
    });
  }
}

class MyProfileIndicators extends StatelessWidget {
  const MyProfileIndicators({Key? key, required this.count, required this.text})
      : super(key: key);
  final String text;
  final String count;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyText2!.color),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
