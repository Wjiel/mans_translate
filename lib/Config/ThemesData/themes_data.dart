import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    elevation: 0,
    selectedLabelStyle: TextStyle(fontSize: 0),
    unselectedLabelStyle: TextStyle(fontSize: 0),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black,
      fontFamily: 'Serif',
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      color: Color(0xFF272727),
      fontFamily: 'Slab',
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
  ),
);

TextStyle buttonTextStyle = const TextStyle(
  color: Colors.white,
  fontFamily: 'Serif',
  fontSize: 20,
  fontWeight: FontWeight.w500,
);
