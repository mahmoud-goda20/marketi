import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  // Colors
  static const Color lightBlue100 = Color(0xFF3F80FF);
  static const Color lightBlue700 = Color(0xFFB2CCFF);
  static const Color lightBlue900 = Color(0xFFD9E6FF);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8FAFF);
  static const Color grayScale = Color(0xFF67687E);
  static const Color red = Color(0xFFEF5A55);
  static const Color green = Color(0xFF4CAF50);
  static const Color darkBlue900 = Color(0xFF001640);
  static const Color navy = Color(0xFF51526C);
  static const Color placeholder = Color(0xFF929BAB);

  // Text styles
  static const TextStyle title = TextStyle(
    color: darkBlue900,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
  );

  static const TextStyle title2 = TextStyle(
    color: darkBlue900,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
  );

  static const TextStyle body = TextStyle(
    color: darkBlue900,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
  );

  static const TextStyle body2 = TextStyle(
    color: navy,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
  );

  static const TextStyle placeholderStyle = TextStyle(
    color: placeholder,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
  );

  static const TextStyle button = TextStyle(
    color: background,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
  );
}
