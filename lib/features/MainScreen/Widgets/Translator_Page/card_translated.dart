import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/MainScreen/Pages/translator_page.dart';
import 'package:mans_translate/features/Widgets/custom_alertdialog.dart';

class CardTranslated extends StatefulWidget {
  Function copyText;
  final ResultTextClass resultTextClass;
  final Stream resultTextStream;
  CardTranslated(
      {super.key,
      required this.copyText,
      required this.resultTextClass,
      required this.resultTextStream});

  @override
  State<CardTranslated> createState() => _CardTranslatedState();
}

bool isHistory = false;

class _CardTranslatedState extends State<CardTranslated>
    with WidgetsBindingObserver {
  Map<String, dynamic> mapHistory = {};
  List historyItem = [
    {
      "sourceText": "Дома бегают дети",
      "targetText": "Дем лак щш",
      "isRussian": true,
      "index": 1,
    }
  ];

  double heightInfoFacts = 60;

  late ResultTextClass _resultTextClass;
  late Stream _resultTextStream;

  bool isKeyboardOpen = false;
  bool _isKeyboardOpen = false;

  @override
  void didChangeMetrics() {
    final value = View.of(context).viewInsets.bottom;
    if (value == 0) {
      if (isKeyboardOpen) {
        _onKeyboardChanged(false);
      }
      isKeyboardOpen = false;
    } else {
      isKeyboardOpen = true;
      _onKeyboardChanged(true);
    }
  }

  _onKeyboardChanged(bool isVisible) {
    Timer(const Duration(milliseconds: 300), () {
      if (isVisible) {
        setState(() {
          _isKeyboardOpen = true;
        });
      } else {
        setState(() {
          _isKeyboardOpen = false;
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resultTextClass = widget.resultTextClass;
    _resultTextStream = widget.resultTextStream;
  }

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
                      visible: _resultTextClass.resultText.isNotEmpty,
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
                            shape: BoxShape.circle,
                            boxShadow: [
                              isHistory
                                  ? const BoxShadow(
                                      spreadRadius: 5,
                                      color: Tertiary,
                                    )
                                  : const BoxShadow(color: Colors.white),
                            ],
                          ),
                          child: Image.asset(
                            isHistory == false
                                ? 'assets/images/time.png'
                                : 'assets/images/time_outline.png',
                            color: Primary,
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
            child: StreamBuilder(
                stream: _resultTextStream,
                initialData: "",
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      AnimatedOpacity(
                        opacity: isHistory ? 0 : 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOutCirc,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            snapshot.data.isNotEmpty
                                ? SelectableText(
                                    style: TextStyle(
                                      fontFamily: themeData
                                          .textTheme.bodySmall!.fontFamily,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                    snapshot.data,
                                  )
                                : Text(
                                    "Здесь будет результат",
                                    style: TextStyle(
                                      color: textColor,
                                      fontFamily: themeData
                                          .textTheme.bodySmall!.fontFamily,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      isHistory
                          ? historyItem.isEmpty
                              ? Center(
                                  child: AnimatedOpacity(
                                    opacity: isHistory == false ? 0 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOutCirc,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/noneText.png',
                                          width: 80,
                                        ),
                                        Text(
                                          'Тут пока ничего нет',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: themeData.textTheme
                                                .bodySmall!.fontFamily,
                                            color: const Color(0xFF606060),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : AnimatedOpacity(
                                  opacity: isHistory == false ? 0 : 1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOutCirc,
                                  child: ListView.builder(
                                    itemCount: historyItem.length,
                                    itemBuilder: (context, i) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: const BorderSide(
                                                  color: Color(0xFFC5C5C5),
                                                ),
                                                bottom: i ==
                                                        historyItem.length - 1
                                                    ? const BorderSide(
                                                        color:
                                                            Color(0xFFC5C5C5),
                                                      )
                                                    : BorderSide.none,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${i + 1}.",
                                                  style: const TextStyle(
                                                    fontFamily: 'Serif',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const Flexible(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AutoSizeText(
                                                      historyItem[i]
                                                          ['sourceText'],
                                                      style: const TextStyle(
                                                        fontFamily: 'Slab',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    AutoSizeText(
                                                      historyItem[i]
                                                              ['isRussian']
                                                          ? 'Русский - Мансийский'
                                                          : 'Мансийский - Русский',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF8B8B8B),
                                                        fontFamily: 'Slab',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                          : const SizedBox.shrink(),
                    ],
                  );
                }),
          ),
          _isKeyboardOpen == false
              ? AnimatedOpacity(
                  opacity: isHistory || historyItem.isEmpty ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCirc,
                  onEnd: () {
                    heightInfoFacts = 0;
                  },
                  child: InkWell(
                    onTap: () {
                      showCustomAlertDialog(
                        context,
                        "Интересный факт",
                        () {
                          Navigator.of(context).pop();
                        },
                        const Text(
                          "Язык манси входит в обширную группу финно-угорских языков и, согласно исследованиям, больше всего схож с венгерским.",
                          style: TextStyle(
                            fontFamily: "Slab",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Ink(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
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
                                      fontFamily: themeData
                                          .textTheme.bodySmall!.fontFamily,
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
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
