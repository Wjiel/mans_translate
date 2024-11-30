import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';

class GameWord extends StatelessWidget {
  bool isRussian;
  GameWord({super.key, required this.isRussian});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF5FD),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            const AutoSizeText(
              'Выберите правельный ответ',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Slab',
                fontWeight: FontWeight.bold,
              ),
            ),
            SourceContainer(
              text: 'dasdas',
            ),
          ],
        ),
      ),
    );
  }
}

class SourceContainer extends StatelessWidget {
  String text;

  SourceContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: shadow,
            blurRadius: 10,
          )
        ],
      ),
      child: AutoSizeText(
        text,
        style: const TextStyle(
          fontFamily: 'Slab',
          fontSize: 35,
          color: Secondary,
        ),
      ),
    );
  }
}
