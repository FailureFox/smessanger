import 'package:flutter/material.dart';
import 'package:smessanger/src/ui/styles/colors.dart';

abstract class AppButtonStyles {
  static final ButtonStyle dYellowButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    onSurface: Colors.white,
    primary: AppColors.yellowTint,
    textStyle: const TextStyle(
      color: AppColors.dbackground,
    ),
  );
}
