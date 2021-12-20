import 'package:flutter/material.dart';
import 'package:smessanger/src/ui/styles/colors.dart';
import 'package:smessanger/src/ui/styles/text_styles.dart';

abstract class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    canvasColor: AppColors.dbackground,
    primaryColor: AppColors.yellowTint,
    appBarTheme: const AppBarTheme(color: AppColors.dbackground),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          onSurface: Colors.white,
          primary: AppColors.yellowTint,
          onPrimary: AppColors.dbackground),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        fillColor: AppColors.dbackgroundLL,
        filled: true),
    textTheme: AppTextThemes.dTextTheme,
    splashFactory: InkSplash.splashFactory,
    backgroundColor: AppColors.dbackground,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(brightness: Brightness.dark, primary: AppColors.yellowTint),
  );

  static final ThemeData lightTheme = ThemeData(
    canvasColor: AppColors.lbackground,
    primaryColor: AppColors.yellowTint,
    backgroundColor: AppColors.lbackground,
    appBarTheme: const AppBarTheme(color: AppColors.lbackground),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        onSurface: Colors.black,
        primary: AppColors.yellowTint,
        onPrimary: AppColors.lbackground,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        fillColor: AppColors.lbackgroundLD,
        filled: true),
    textTheme: AppTextThemes.lTextTheme,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(brightness: Brightness.light, primary: AppColors.yellowTint),
  );
}
