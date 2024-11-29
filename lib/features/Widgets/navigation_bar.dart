import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/features/MainScreen/main_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndexPage = 0;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeItem = 30 + 5 * (size.width / 1080);

    Widget container(Widget child) {
      return Container(
        padding:  EdgeInsets.symmetric(horizontal: 28, vertical: 6),
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Tertiary,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(30),
            left: Radius.circular(30),
          ),
        ),
        child: child,
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
          setState(() {
            currentIndexPage = index;
          });

          pageControllerMain.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutExpo,
          );
        },
      ),
    );
  }
}
