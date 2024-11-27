import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/MainScreen/Pages/translator_page.dart';
import 'package:mans_translate/features/MainScreen/Widgets/Translator_Page/paste_button.dart';

class CardTranslating extends StatelessWidget {
  const CardTranslating({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(20),
      decoration: decorationContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCirc,
              child: AutoSizeText(
                isRussian ? 'Русский' : 'Манскийcкий',
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Введите текст...',
                    hintStyle: TextStyle(
                      color: textColor,
                      fontFamily: themeData.textTheme.bodySmall!.fontFamily,
                      fontWeight: themeData.textTheme.bodySmall!.fontWeight,
                      fontSize: themeData.textTheme.bodySmall!.fontSize,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<dynamic>(
            stream: streamVisib.strims,
            builder: (context, snapshot) {
              if (!snapshot.hasData || streamVisib.thereClipBordText == false) {
                return const SizedBox();
              }

              return Visibility(
                visible: streamVisib.thereClipBordText,
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: PasteButton(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
