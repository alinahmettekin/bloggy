import 'package:bloggy/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
        border: _border(),
        contentPadding: EdgeInsets.all(27),
        enabledBorder: _border(AppPallete.borderColor),
        focusedBorder: _border(AppPallete.gradient2),
        errorBorder: _border(AppPallete.errorColor)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppPallete.backgroundColor,
    ),
    chipTheme: ChipThemeData(
      color: WidgetStateProperty.all(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),
  );
}
