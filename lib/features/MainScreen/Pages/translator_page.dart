import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/features/MainScreen/Widgets/Translator_Page/card_translated.dart';
import 'package:mans_translate/features/MainScreen/Widgets/Translator_Page/card_translating.dart';
import 'package:rive/rive.dart';

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

class ResultTextClass {
  final StreamController _resultTextController = StreamController.broadcast();
  String _resultText = "";

  set resultText(String result) {
    _resultText = result;
  }

  String get resultText => _resultText;

  Stream resultTextStream() {
    _resultTextController.add(_resultText);

    return _resultTextController.stream;
  }
}

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage>
    with WidgetsBindingObserver {
  final ResultTextClass _resultTextClass = ResultTextClass();
  late Stream _resultTextStream;
  final TextEditingController _sourceEditingController =
      TextEditingController();
  late StreamController _resultStreamController;

  bool isKeyboardOpen = false;

  Artboard? _arrowsArtboard;
  SMITrigger? trigger;
  StateMachineController? stateMachineController;

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
      ClipboardData(text: _resultTextClass.resultText),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resultTextStream = _resultTextClass.resultTextStream();
    _resultStreamController = _resultTextClass._resultTextController;
    _loadArrowAnim();
  }

  void _loadArrowAnim() {
    rootBundle.load('assets/animations/switchArrows.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "State Machine 1");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);
          trigger = stateMachineController!.findSMI('Trigger 1');

          for (var e in stateMachineController!.inputs) {}
          trigger = stateMachineController!.inputs.first as SMITrigger;
        }

        setState(() => _arrowsArtboard = artboard);
      },
    );
  }

  void changeCard(znach) {
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
        String sourceText = _sourceEditingController.text;
        String resultText = znach;
        _resultStreamController.add(sourceText);
        _sourceEditingController.text = resultText;
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
                  child: CardTranslating(
                    sourceEditingController: _sourceEditingController,
                    resultTextClass: _resultTextClass,
                    resultTextStreamController: _resultStreamController,
                  ),
                ),
              ),
              SizedBox(
                height: 70 + 5 * (size.width / 1080),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: StreamBuilder(
                      stream: _resultTextStream,
                      builder: (context, snapshot) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            changeCard(snapshot.data ?? "");
                            trigger?.fire();
                          },
                          child: _arrowsArtboard != null
                              ? Rive(
                                  artboard: _arrowsArtboard!,
                                  fit: BoxFit.scaleDown,
                                )
                              : const SizedBox(),
                        );
                      }),
                ),
              ),
              Expanded(
                  child: AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCirc,
                child: CardTranslated(
                  resultTextClass: _resultTextClass,
                  copyText: () {
                    copyText();
                  },
                  resultTextStream: _resultTextStream,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
