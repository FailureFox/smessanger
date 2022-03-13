import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_bloc.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/repositories/chats_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/user_repository.dart';
import 'package:smessanger/src/ui/pages/chat_pages/sub_pages/chat_room_page.dart';
import 'package:smessanger/injections.dart' as rep;

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.profile}) : super(key: key);
  final UserModel profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          BlocProvider.of<AppBloc>(context).state.uid != profile.uid
              ? FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            ChatRoomPage(chatId: null, user: profile),
                      ),
                    );
                  },
                  child: const Icon(Icons.message),
                )
              : FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                  child: const Icon(Icons.add_a_photo_outlined),
                ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ProfileTitle(profile: profile),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
                20,
                (index) => Container(
                      margin: const EdgeInsets.all(5),
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width / 3.4,
                      height: 20,
                    )),
          )
        ],
      ),
    );
  }
}

class ProfileTitle extends StatelessWidget {
  const ProfileTitle({Key? key, required this.profile}) : super(key: key);
  final UserModel profile;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.1,
      width: double.infinity,
      color: Theme.of(context).hoverColor,
      child: Column(
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          CircleAvatar(
            radius: MediaQuery.of(context).size.width / 8,
            backgroundImage: NetworkImage(profile.avatarUrl!),
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                '${profile.name} ${profile.surname}',
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
                MyProfileIndicators(
                    count: profile.followers.length.toString(),
                    text: 'followers'),
                VerticalDivider(width: 0, color: Theme.of(context).hintColor),
                MyProfileIndicators(
                    count: profile.following.length.toString(),
                    text: 'following'),
                VerticalDivider(width: 0, color: Theme.of(context).hintColor),
                MyProfileIndicators(
                    count: profile.groups.length.toString(), text: 'groups'),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
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
