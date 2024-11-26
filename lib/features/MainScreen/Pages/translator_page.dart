import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        color: shadow,
        blurRadius: 20,
      ),
    ],
  );

  final double paddingContainer = 20;

  String translateText = 'Здесь будет результат';

  Color textColor = const Color(0xFFA8A8A8);

  void copyText() {
    Clipboard.setData(
      ClipboardData(text: translateText),
    );
    checkTextBoard();
  }

  bool isVisib = false;

  void checkTextBoard() async {
    isVisib = await Clipboard.hasStrings();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkTextBoard();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Expanded(
                child: Ink(
                  padding: EdgeInsets.all(paddingContainer),
                  decoration: decoration,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: AutoSizeText(
                              'Манскийcкий',
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: const [
                                TextField(),
                              ],
                            ),
                          )
                        ],
                      ),
                      Visibility(
                        visible: isVisib,
                        child: const Align(
                          alignment: Alignment.bottomLeft,
                          child: PastButton(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70 + 5 * (size.width / 1080),
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/arrows.png',
                    color: Tertiary,
                    width: 35 + 5 * (size.width / 1080),
                  ),
                ),
              ),
              Expanded(
                child: Ink(
                  padding: EdgeInsets.all(paddingContainer),
                  decoration: decoration,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AutoSizeText(
                              'Русский',
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
                                fontFamily:
                                    themeData.textTheme.bodySmall!.fontFamily,
                                fontWeight:
                                    themeData.textTheme.bodySmall!.fontWeight,
                                fontSize:
                                    themeData.textTheme.bodySmall!.fontSize,
                              ),
                              translateText,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PastButton extends StatelessWidget {
  const PastButton({super.key});
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
