import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/ui/core/colors/marketlist_colors.dart';

ThemeData getThemeData() {
  return ThemeData(
    primaryColor: MarketListColors.white,
    colorScheme: const ColorScheme(
      primary: MarketListColors.white,
      secondary: MarketListColors.green,
      surface: MarketListColors.white,
      error: MarketListColors.red,
      onPrimary: MarketListColors.white,
      onSecondary: MarketListColors.green,
      onSurface: MarketListColors.black,
      onError: MarketListColors.red,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    dialogTheme: DialogTheme(
      backgroundColor: MarketListColors.white,
      titleTextStyle: TextStyle(color: MarketListColors.black),
      contentTextStyle: TextStyle(color: MarketListColors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: MarketListColors.black,
      ),
    ),
  );
}
