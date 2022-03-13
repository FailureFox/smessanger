import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_event.dart';
import 'package:smessanger/src/bloc/home_bloc/home_state.dart';
import 'package:smessanger/src/ui/pages/chat_pages/chats_page.dart';
import 'package:smessanger/src/ui/pages/home_pages/settings_page.dart';
import 'package:unicons/unicons.dart';
import 'package:smessanger/injections.dart' as rep;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => rep.sl.call<HomeBloc>()),
      BlocProvider(
        create: (_) => ChatBloc(
          uid: BlocProvider.of<AppBloc>(context).state.uid,
          chatRep: rep.sl.call(),
          userRepo: rep.sl.call(),
        ),
      )
    ], child: const _HomeScreen());
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(
          HomeLoadingEvent(uid: context.read<AppBloc>().state.uid),
        );
  }

  static const List<Widget> pages = <Widget>[
    ChatPage(),
    SizedBox(),
    SizedBox(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        body: pages[state.page],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            FocusScope.of(context).unfocus();
            context.read<HomeBloc>().add(HomePageChangeEvent(page: index));
          },
          selectedFontSize: 11,
          unselectedFontSize: 11,
          currentIndex: state.page,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(UniconsLine.chat), label: 'Messages'),
            BottomNavigationBarItem(
                icon: Icon(UniconsLine.phone), label: 'Calls'),
            BottomNavigationBarItem(
                icon: Icon(UniconsLine.users_alt), label: 'contacts'),
            BottomNavigationBarItem(
                icon: Icon(UniconsLine.setting), label: "Settings"),
          ],
        ),
      );
    });
  }
}
