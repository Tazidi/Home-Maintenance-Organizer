import 'package:flutter/material.dart';

class AppColors {
  static const black = Color(0xFF000000);
  static const darkOlive = Color(0xFF262719);
  static const oliveGray = Color(0xFF414B3B);
  static const charcoalGray = Color(0xFF54514A);
  static const warmSand = Color(0xFFD0C8BB);
  static const ivory = Color(0xFFF8F7F2);
  static const lightPink = Color(0xFFFFEBEB);
  static const linen = Color(0xFFFFF9F3);
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFF797979);
  static const darkGrey = Color(0xFF635C5C);
  // static const darkerGrey = Color(0xFF222222);
  // static const darkBlue = Color(0xFF0B6EFE);
}

class TextStyles {
  static TextStyle title = const TextStyle(
    fontFamily: 'Outfit',
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: AppColors.darkOlive,
  );

  static TextStyle body = const TextStyle(
    fontFamily: 'Outfit',
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
    color: AppColors.darkOlive,
  );
}
