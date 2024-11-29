import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/features/MainScreen/Widgets/Translator_Page/card_translated.dart';
import 'package:mans_translate/features/MainScreen/Widgets/Translator_Page/card_translating.dart';

String translateText = '';

Color textColor = const Color(0xFFA8A8A8);

final decorationContainer = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: Colors.white,
  boxShadow: const [
    BoxShadow(
      color: shadow,
      blurRadius: 20,
    ),
  ],
);

class _myStream {
  late bool thereClipBordText = false;

  set isBoard(bool isThere) {
    thereClipBordText = isThere;
    _controller.add(thereClipBordText);
  }

  final StreamController<bool> _controller = StreamController.broadcast();

  Stream<bool> get strims => _controller.stream;
}

final _myStream streamVisib = _myStream();

bool isRussian = false;

double opacity = 1;
double scale = 1;

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {

  
  void copyText() {
    Clipboard.setData(
      ClipboardData(text: translateText),
    );
    checkTextBoard();
  }

  void checkTextBoard() async {
    streamVisib.isBoard = await Clipboard.hasStrings();
  }

  @override
  void initState() {
    super.initState();
    checkTextBoard();
  }

  void changeCard() {
    setState(() {
      opacity = 0;
      scale = 0.9;
    });
    Timer.periodic(const Duration(milliseconds: 300), (ce) {
      setState(() {
        opacity = 1;
        scale = 1;
        isRussian = !isRussian;
      });
      ce.cancel();
    });
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
              // ignore: prefer_const_constructors
              Expanded(
                // ignore: prefer_const_constructors
                child: AnimatedScale(
                  scale: scale,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCirc,
                  // ignore: prefer_const_constructors
                  child: CardTranslating(),
                ),
              ),
              SizedBox(
                height: 70 + 5 * (size.width / 1080),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      changeCard();
                    },
                    child: Image.asset(
                      'assets/images/arrows.png',
                      color: Tertiary,
                      width: 35 + 5 * (size.width / 1080),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCirc,
                child: CardTranslated(
                  copyText: () {
                    copyText();
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
