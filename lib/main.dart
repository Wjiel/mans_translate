import 'package:flutter/material.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';

import 'package:mans_translate/features/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: const SplashScreen(),
    );
  }
}
