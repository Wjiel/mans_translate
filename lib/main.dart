import 'package:flutter/material.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/StartScreen/start_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: themeData,
      home: StartScreen(),
    ),
  );
}
