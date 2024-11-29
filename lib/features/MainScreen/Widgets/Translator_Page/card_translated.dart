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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCirc,
                child: AutoSizeText(
                  style: const TextStyle(
                    fontFamily: 'Serif',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  isRussian ? 'Мансийcкий' : 'Русский',
                ),
              ),
              Visibility(
                visible: translateText.isNotEmpty,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    copyText();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.copy, color: Tertiary),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                translateText.isNotEmpty
                    ? SelectableText(
                        style: TextStyle(
                          fontFamily: themeData.textTheme.bodySmall!.fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        translateText,
                      )
                    : Text(
                        "Здесь будет результат",
                        style: TextStyle(
                          color: textColor,
                          fontFamily: themeData.textTheme.bodySmall!.fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
