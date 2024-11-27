import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/MainScreen/Pages/translator_page.dart';

class CardTranslated extends StatelessWidget {
  Function copyText;
  CardTranslated({super.key, required this.copyText});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(20),
      decoration: decorationContainer,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCirc,
                  child: AutoSizeText(
                    isRussian ? 'Манскийcкий' : 'Русский',
                  ),
                ),
                InkWell(
                  onTap: () {
                    copyText();
                  },
                  child: const Icon(
                    Icons.copy,
                    color: Tertiary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                SelectableText(
                  style: TextStyle(
                    color: textColor,
                    fontFamily: themeData.textTheme.bodySmall!.fontFamily,
                    fontWeight: themeData.textTheme.bodySmall!.fontWeight,
                    fontSize: themeData.textTheme.bodySmall!.fontSize,
                  ),
                  translateText,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
