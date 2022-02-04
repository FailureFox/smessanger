import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_event.dart';
import 'package:smessanger/src/bloc/home_bloc/home_state.dart';
import 'package:smessanger/src/ui/pages/home_pages/chats_page.dart';
import 'package:smessanger/src/ui/pages/home_pages/films_page.dart';
import 'package:smessanger/src/ui/pages/home_pages/news_page.dart';
import 'package:smessanger/src/ui/pages/home_pages/settings_page.dart';
import 'package:unicons/unicons.dart';
import 'package:smessanger/injections.dart' as rep;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (_) => rep.sl.call<HomeBloc>(), child: const _HomeScreen());
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        body: IndexedStack(
          index: state.page,
          children: const [
            NewsPage(),
            ChatPage(),
            FilmsMainPage(),
            SettingsPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) =>
              context.read<HomeBloc>().add(HomePageChangeEvent(page: index)),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          currentIndex: state.page,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(UniconsLine.home_alt), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(UniconsLine.chat), label: 'Messages'),
            BottomNavigationBarItem(
                icon: Icon(UniconsLine.film), label: "Films"),
            BottomNavigationBarItem(
                icon: Icon(UniconsLine.setting), label: "Settings"),
          ],
        ),
      );
    });
  }
}
