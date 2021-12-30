import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);
  final List<Widget> pages = const [
    NewsPage(),
    ChatPage(),
    FilmsPage(),
    SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        body: pages[state.page],
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
