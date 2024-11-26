import 'package:flutter/material.dart';
import 'package:mans_translate/features/MainScreen/Pages/game_page.dart';
import 'package:mans_translate/features/MainScreen/Pages/translator_page.dart';
import 'package:mans_translate/features/Widgets/navigation_bar.dart';

final PageController pageControllerMain = PageController();

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final _pages = [
    TranslatorPage(),
    const GamePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(),
      body: PageView(
        controller: pageControllerMain,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}
