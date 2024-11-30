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

bool isRussian = false;

double opacity = 1;
double scale = 1;

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage>
    with WidgetsBindingObserver {
  final StreamController _keyboardController = StreamController();

  Stream _focusStream() {
    _keyboardController.add(false);

    return _keyboardController.stream;
  }

  var isKeyboardOpen = false;

  ///
  /// This routine is invoked when the window metrics have changed.
  ///
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
          _translatingFlex = 2;
        });
      } else {
        setState(() {
          _translatingFlex = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void copyText() {
    Clipboard.setData(
      ClipboardData(text: translateText),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void changeCard() {
    setState(() {
      isHistory = false;

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

  int _translatingFlex = 1;

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
                flex: _translatingFlex,
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
