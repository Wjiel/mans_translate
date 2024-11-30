import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';

class AnswerContainer extends StatelessWidget {
  String text;
  Function function;

  AnswerContainer({
    super.key,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double radius = 15;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          function();
        },
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: size.width,
          decoration: BoxDecoration(
            color: Secondary,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: AutoSizeText(
              text,
              style: const TextStyle(
                fontFamily: 'Slab',
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
