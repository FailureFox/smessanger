import 'package:flutter/material.dart';
import 'package:smessanger/src/ui/styles/colors.dart';

abstract class AppTextThemes {
  static const TextTheme dTextTheme = TextTheme(
    // headline1: TextStyle(
    //     fontWeight: FontWeight.w700, fontSize: 17, color: Colors.white),
    headline1: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Editor',
        fontSize: 32,
        color: Colors.white),
    headline2: TextStyle(
        fontWeight: FontWeight.w700 , fontSize: 17, color: Colors.white),
    bodyText1: TextStyle(
        fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),
    bodyText2: TextStyle(
        fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white54),
    // caption: TextStyle(
    //     fontWeight: FontWeight.normal, color: Colors.white, fontSize: 13),
  );

  static const TextTheme lTextTheme = TextTheme(
    headline1: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Editor',
        fontSize: 32,
        color: Colors.black),
    headline2: TextStyle(
        fontWeight: FontWeight.normal, fontSize: 17, color: Colors.black),
    bodyText1: TextStyle(
        fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
    bodyText2: TextStyle(
        fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black45),
    // caption: TextStyle(
    //     fontWeight: FontWeight.normal, color: Colors.black, fontSize: 13),
  );
}

class MyTextStyles {
  static const buttonTextStyle = TextStyle(
      fontWeight: FontWeight.w700, color: AppColors.dbackground, fontSize: 17);
  static const hero1 = TextStyle(
      fontWeight: FontWeight.bold, fontFamily: 'Editor', fontSize: 40);
  static const hero2 = TextStyle(
      fontWeight: FontWeight.bold, fontFamily: 'Editor', fontSize: 24);
}
