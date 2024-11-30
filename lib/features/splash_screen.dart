import 'package:flutter/material.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/StartScreen/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List _allAsset = [
    "assets/images/arrows.png",
    "assets/images/game_outline.png",
    "assets/images/game.png",
    "assets/images/translate_outline.png",
    "assets/images/translate.png",
    "assets/images/time.png",
    "assets/images/time_outline.png",
    "assets/images/noneText.png",
    "assets/images/taskword.png",
    "assets/images/taskwordmans.png",
    "assets/images/alphab.png",
    "assets/images/taskfraz.png",
    "assets/images/taskpredloz.png",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLaunch();
    });
  }

  Future _checkLaunch() async {
    for (var asset in _allAsset) {
      await precacheImage(AssetImage(asset), context);
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => StartScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        body: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/images/translate.png")),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
