import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/features/MainScreen/Widgets/Translator_Page/card_translated.dart';
import 'package:mans_translate/features/MainScreen/main_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndexPage = 0;

  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6);

  @override
  void initState() {
    super.initState();

    changeAnim();
  }

  void changeAnim() {
    setState(() {
      padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
    });
    Timer.periodic(const Duration(milliseconds: 100), (ce) {
      setState(() {
        padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 6);
      });
      ce.cancel();
    });
  }

  void swich(int index) {
    setState(() {
      currentIndexPage = index;
    });
    isHistory = false;
    pageControllerMain.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutExpo,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeItem = 30 + 5 * (size.width / 1080);

    Widget container(Widget child) {
      return Container(
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Tertiary,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(30),
            left: Radius.circular(30),
          ),
        ),
        child: AnimatedPadding(
          curve: Curves.easeInOutCubic,
          padding: padding,
          duration: const Duration(milliseconds: 200),
          child: child,
        ),
      );
    }

    final items = [
      BottomNavigationBarItem(
        activeIcon: container(
          Image.asset(
            'assets/images/translate.png',
            width: sizeItem,
            color: bottomBarIcon,
          ),
        ),
        icon: Image.asset(
          'assets/images/translate_outline.png',
          width: sizeItem,
          color: bottomBarIcon,
        ),
        label: '',
        tooltip: 'Translate',
      ),
      BottomNavigationBarItem(
        activeIcon: container(
          Image.asset(
            'assets/images/game.png',
            width: sizeItem,
            color: bottomBarIcon,
          ),
        ),
        icon: Image.asset(
          'assets/images/game_outline.png',
          width: sizeItem,
          color: bottomBarIcon,
        ),
        label: '',
        tooltip: 'Game',
      ),
    ];
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFC8C8C8),
          ),
        ),
      ),
      child: BottomNavigationBar(
        items: items,
        currentIndex: currentIndexPage,
        onTap: (index) {
          if (index != currentIndexPage) {
            changeAnim();
          }

          swich(index);
        },
      ),
    );
  }
}
