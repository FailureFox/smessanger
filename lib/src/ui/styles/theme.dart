import 'package:flutter/material.dart';
import 'package:smessanger/src/ui/styles/colors.dart';
import 'package:smessanger/src/ui/styles/text_styles.dart';

abstract class AppTheme {
  static final ThemeData darkTheme = ThemeData(
      dialogBackgroundColor: AppColors.dbackgroundML,
      scaffoldBackgroundColor: AppColors.dbackground,
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: AppColors.dbackgroundLL),
      appBarTheme: const AppBarTheme(color: AppColors.dbackground),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            onSurface: Colors.white,
            primary: AppColors.yellowTint,
            onPrimary: AppColors.dbackground),
      ),
      inputDecorationTheme: const InputDecorationTheme(
          isDense: false,
          border: InputBorder.none,
          fillColor: AppColors.dbackgroundLL,
          filled: true),
      textTheme: AppTextThemes.dTextTheme,
      hintColor: AppColors.dforegroundML,
      splashFactory: InkSplash.splashFactory,
      backgroundColor: AppColors.dbackgroundML,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.dark,
        primary: AppColors.yellowTint,
      ),
      iconTheme: const IconThemeData(color: AppColors.dforegroundML));

  static final ThemeData lightTheme = ThemeData(
    iconTheme: const IconThemeData(color: AppColors.lforegroundML),
    canvasColor: AppColors.lbackground,
    scaffoldBackgroundColor: AppColors.lbackground,
    backgroundColor: AppColors.lbackgroundMD,
    appBarTheme: const AppBarTheme(color: AppColors.lbackground),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        onSurface: Colors.black,
        primary: AppColors.yellowTint,
        onPrimary: AppColors.lbackground,
      ),
    ),
    hintColor: AppColors.lforeground,
    inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        fillColor: AppColors.lbackgroundLD,
        filled: true),
    textTheme: AppTextThemes.lTextTheme,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(brightness: Brightness.light, primary: AppColors.yellowTint),
  );
}
