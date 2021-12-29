import 'package:flutter/material.dart';
import 'package:smessanger/src/ui/pages/home_pages/news_page.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const NewsPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 11,
        unselectedFontSize: 11,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.home_alt), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.chat), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded), label: "Notice's"),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.setting), label: "Settings"),
        ],
      ),
    );
  }
}
