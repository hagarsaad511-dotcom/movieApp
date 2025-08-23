import 'package:flutter/material.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.bgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: false,
      showSelectedLabels: false,
    )


  );
}