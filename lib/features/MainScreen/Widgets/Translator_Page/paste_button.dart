import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';

class PasteButton extends StatelessWidget {
  const PasteButton({super.key});
  final double radius = 20;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(radius),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: Secondary,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.content_paste,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            AutoSizeText(
              'Вставить',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: themeData.textTheme.bodySmall!.fontFamily,
                fontWeight: themeData.textTheme.bodySmall!.fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
