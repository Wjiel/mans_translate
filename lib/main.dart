import 'package:flutter/material.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';

import 'package:mans_translate/features/splash_screen.dart';
import 'package:rive/rive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  await RiveFile.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
