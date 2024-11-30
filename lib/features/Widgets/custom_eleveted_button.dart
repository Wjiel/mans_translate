import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';

class CustomElevetedButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function function;
  final double radius;
  const CustomElevetedButton({
    super.key,
    required this.color,
    required this.text,
    required this.function,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        function();
      },
      borderRadius: BorderRadius.circular(radius),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        width: size.width,
        height: 40 + 30 * (size.width / 1080),
        child: Center(
          child: AutoSizeText(
            text,
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
