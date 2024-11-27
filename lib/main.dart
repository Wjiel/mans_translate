import 'package:flutter/material.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/MainScreen/main_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: themeData,
      home: MainScreen(),
    ),
  );
}
