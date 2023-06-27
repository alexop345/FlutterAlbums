import 'package:albums/themes/app_colors.dart';
import 'package:albums/themes/app_font_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      // iconTheme: IconThemeData(color: Colors.red),
      // actionsIconTheme: IconThemeData(color: Colors.amber),
      titleTextStyle: AppFontStyle.appBarText
    ),
  );
}
