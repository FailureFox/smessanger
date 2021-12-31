import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smessanger/src/bloc/home_bloc/home_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ScrollController controller = ScrollController();
  bool isClosed = false;
  bool get _isSliverAppBarExpanded {
    return controller.hasClients && controller.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      isClosed = _isSliverAppBarExpanded;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: AnimatedCrossFade(
              firstChild: const Text(
                'Settings',
                style: TextStyle(color: Colors.black),
              ),
              secondChild: const SizedBox(),
              crossFadeState: isClosed
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 200)),
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top),
                  Text('Settings',
                      style: Theme.of(context).textTheme.headline1),
                  const SizedBox(height: 15),
                  const SettingsTitle(),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
        SliverList(delegate: SliverChildListDelegate([const SettingsBody()]))
      ],
    );
  }
}

class SettingsBody extends StatelessWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsComponents(
              text: 'Edit profile', icon: Icons.edit_outlined, function: () {}),
          SettingsComponents(
              text: 'Communicate', icon: Icons.public, function: () {}),
          SettingsComponents(
              text: 'Firends', icon: Icons.person_outline, function: () {}),
          const SizedBox(height: 15),
          Text(
            'Settings',
            style: TextStyle(
                fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
                fontSize: 20,
                color: Theme.of(context).textTheme.headline1!.color),
          ),
          const SizedBox(height: 15),
          SettingsComponents(
              text: 'Accounts and Privacy',
              icon: Icons.privacy_tip_outlined,
              function: () {}),
          SettingsComponents(
              text: 'Notification',
              icon: Icons.notifications_outlined,
              function: () {}),
          SettingsComponents(
              text: 'Sounds', icon: Icons.person_outline, function: () {}),
          const SizedBox(height: 15),
          Text(
            'Other',
            style: TextStyle(
                fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
                fontSize: 20,
                color: Theme.of(context).textTheme.headline1!.color),
          ),
          const SizedBox(height: 15),
          SettingsComponents(
              text: 'User guide',
              icon: Icons.menu_book_outlined,
              function: () {}),
          SettingsComponents(
              text: 'Help and feedback',
              icon: Icons.help_outline,
              function: () {}),
          SettingsComponents(
              text: 'Log Out',
              icon: Icons.exit_to_app_outlined,
              function: () {}),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state.myProfile != null) {
        return Row(
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width / 12,
              backgroundImage: NetworkImage(state.myProfile!.avatarUrl!),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.myProfile!.name + (state.myProfile!.surname ?? ''),
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text('@${state.myProfile!.name.toLowerCase()}')
              ],
            )
          ],
        );
      } else {
        return Row(
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width / 12,
              child: Shimmer(child: Container()),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer(
                    child: Container(
                        height: 5,
                        width: MediaQuery.of(context).size.width / 2)),
                Shimmer(
                    child: Container(
                        height: 5,
                        width: MediaQuery.of(context).size.width / 3))
              ],
            )
          ],
        );
      }
    });
  }
}

class SettingsComponents extends StatelessWidget {
  const SettingsComponents(
      {Key? key,
      required this.text,
      required this.icon,
      required this.function})
      : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).backgroundColor,
        child: Icon(icon, color: Theme.of(context).hintColor),
      ),
      title: Text(text, style: Theme.of(context).textTheme.headline2),
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 15),
    );
  }
}
/*
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      final myStatus = state.status;
      if (myStatus == HomeStatus.loaded) {
        return Container(
          height: MediaQuery.of(context).size.height / 2.1,
          width: double.infinity,
          color: Theme.of(context).hoverColor,
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                    splashRadius: 20,
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Theme.of(context).iconTheme.color,
                    )),
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: const [LightDarkIconButton()],
              ),
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
                    MyProfileIndicators(
                        count: state.myProfile!.followers.length.toString(),
                        text: 'followers'),
                    VerticalDivider(
                        width: 0, color: Theme.of(context).hintColor),
                    MyProfileIndicators(
                        count: state.myProfile!.following.length.toString(),
                        text: 'following'),
                    VerticalDivider(
                        width: 0, color: Theme.of(context).hintColor),
                    MyProfileIndicators(
                        count: state.myProfile!.groups.length.toString(),
                        text: 'groups'),
                  ],  
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });


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
*/
