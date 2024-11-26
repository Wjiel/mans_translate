import 'package:flutter/material.dart';
import 'package:mans_translate/features/StartScreen/Pages/hello_page.dart';
import 'package:mans_translate/features/StartScreen/Pages/seccond_page.dart';

final PageController pageControllerStart = PageController();

class StartScreen extends StatelessWidget {
  StartScreen({super.key});

  final _pages = [
    const HelloPage(),
    const SeccondPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageControllerStart,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}
