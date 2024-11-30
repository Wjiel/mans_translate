import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/MainScreen/Pages/translator_page.dart';

class CardTranslated extends StatefulWidget {
  Function copyText;
  CardTranslated({super.key, required this.copyText});

  @override
  State<CardTranslated> createState() => _CardTranslatedState();
}

bool isHistory = false;

class _CardTranslatedState extends State<CardTranslated> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              SizedBox(
                height: 30 + 20 * (size.height / 2400),
                child: Row(
                  children: [
                    Visibility(
                      visible: translateText.isNotEmpty,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          widget.copyText();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.copy, color: Tertiary),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        setState(() {
                          isHistory = !isHistory;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              isHistory
                                  ? const BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 5,
                                      color: Tertiary,
                                    )
                                  : const BoxShadow(),
                            ],
                          ),
                          child: Image.asset(
                            isHistory == false
                                ? 'assets/images/time.png'
                                : 'assets/images/time_outline.png',
                            color: Secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            flex: 3,
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
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Ink(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 2,
                      color: shadow,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/info.png'),
                    const Flexible(
                      child: SizedBox(
                        width: 10,
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: AutoSizeText(
                              'Интересные факты',
                              minFontSize: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Манси использовали шкуру енотов для',
                              style: TextStyle(
                                color: textColor,
                                fontFamily:
                                    themeData.textTheme.bodySmall!.fontFamily,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
