import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/MainScreen/Pages/translator_page.dart';
import 'package:mans_translate/features/Widgets/custom_alertdialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rive/rive.dart';
import 'package:flutter/src/widgets/image.dart' as Image;

class CardTranslated extends StatefulWidget {
  Function copyText;
  final ResultTextClass resultTextClass;
  final Stream resultTextStream;
  final void Function() translatorSetState;
  final StreamController resultStreamController;
  final TextEditingController sourceEditingController;
  final List<Map<String,dynamic>> historyItems;
  CardTranslated(
      {super.key,
      required this.copyText,
      required this.resultTextClass,
      required this.resultTextStream,
        required this.sourceEditingController,
        required this.resultStreamController,
        required this.translatorSetState, required this.historyItems});

  @override
  State<CardTranslated> createState() => _CardTranslatedState();
}

bool isHistory = false;

class _CardTranslatedState extends State<CardTranslated>
    with WidgetsBindingObserver {
  List<String> facts = [];

  int randomNumber = 0;

  bool isReady = false;

  Future<void> initFirebaseFacts() async {
    var db = FirebaseFirestore.instance;
    await db.collection("Facts").get().then((QuerySnapshot querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        facts.add(data["text_facts"]);
      }
    });

    int random(int min, int max) {
      return min + Random().nextInt(max - min);
    }

    randomNumber = random(0, facts.length);
    isReady = true;
    setState(() {});
  }

  List<Map<String,dynamic>> historyItems = [

  ];

  double heightInfoFacts = 60;

  late ResultTextClass _resultTextClass;
  late Stream _resultTextStream;

  bool isKeyboardOpen = false;
  bool _isKeyboardOpen = false;

  Artboard? _copyArtboard;
  SMITrigger? copyTrigger;
  StateMachineController? copyStateMachineController;

  Artboard? _historyArtboard;
  SMITrigger? historyTrigger;
  StateMachineController? historyStateMachineController;

  Artboard? _emptyHistoryArtboard;
  SMITrigger? emptyHistoryTrigger;
  StateMachineController? emptyHistoryStateMachineController;

  void _setHistory(int index) {
    widget.sourceEditingController.text = historyItems[index]["sourceText"];
    widget.resultStreamController.add(historyItems[index]["targetText"]);
    isRussian = historyItems[index]["isRussian"];
    setState(() {
      widget.translatorSetState();
    });
  }

  void _copyAnim() {
    rootBundle.load('assets/animations/copy.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        copyStateMachineController =
            StateMachineController.fromArtboard(artboard, "State Machine 1");
        if (copyStateMachineController != null) {
          artboard.addController(copyStateMachineController!);
          copyTrigger = copyStateMachineController!.findSMI('Trigger 1');

          for (var e in copyStateMachineController!.inputs) {

          }
          copyTrigger = copyStateMachineController!.inputs.first as SMITrigger;
        }

        setState(() => _copyArtboard = artboard);
      },
    );
  }

  void _historyAnim() {
    rootBundle.load('assets/animations/history.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        historyStateMachineController =
            StateMachineController.fromArtboard(artboard, "State Machine 1");
        if (historyStateMachineController != null) {
          artboard.addController(historyStateMachineController!);
          historyTrigger = historyStateMachineController!.findSMI('Trigger 1');

          for (var e in historyStateMachineController!.inputs) {}
          historyTrigger =
              historyStateMachineController!.inputs.first as SMITrigger;
        }

        setState(() => _historyArtboard = artboard);
      },
    );
  }

  void _emptyHistoryAnim() {
    rootBundle.load('assets/animations/emptyHistory.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        emptyHistoryStateMachineController =
            StateMachineController.fromArtboard(artboard, "State Machine 1");
        if (emptyHistoryStateMachineController != null) {
          artboard.addController(emptyHistoryStateMachineController!);
          emptyHistoryTrigger =
              emptyHistoryStateMachineController!.findSMI('Trigger 1');

          for (var e in emptyHistoryStateMachineController!.inputs) {}
          emptyHistoryTrigger =
              emptyHistoryStateMachineController!.inputs.first as SMITrigger;
        }

        setState(() => _emptyHistoryArtboard = artboard);
      },
    );
  }

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
    historyItems = widget.historyItems;
    _copyAnim();
    _historyAnim();
    _emptyHistoryAnim();

    initFirebaseFacts();
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
                    StreamBuilder(
                        stream: _resultTextStream,
                        initialData: "",
                        builder: (context, snapshot) {
                          return Visibility(
                            visible: snapshot.data.isNotEmpty,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                Fluttertoast.showToast(msg: "Скопировано!");
                                _resultTextClass.resultText = snapshot.data;
                                widget.copyText();
                                copyTrigger?.fire();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _copyArtboard != null
                                    ? Transform.scale(
                                        scale: 1.5,
                                        child: Rive(
                                          useArtboardSize: true,
                                          artboard: _copyArtboard!,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        setState(() {
                          isHistory = !isHistory;
                          historyTrigger?.fire();
                          if (historyItems.isEmpty) {
                            emptyHistoryTrigger?.fire();
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              isHistory
                                  ? const BoxShadow(
                                      spreadRadius: 5,
                                      color: Color(0x665C8BE1),
                                    )
                                  : const BoxShadow(color: Colors.white),
                            ],
                          ),
                          child: Transform.scale(
                            scale: 1,
                            child: _historyArtboard != null
                                ? Rive(
                                    useArtboardSize: true,
                                    artboard: _historyArtboard!,
                                    fit: BoxFit.scaleDown,
                                  )
                                : const SizedBox(),
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
                          ? historyItems.isEmpty
                              ? Center(
                                  child: AnimatedOpacity(
                                    opacity: isHistory == false ? 0 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOutCirc,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Transform.scale(
                                            scale: 1,
                                            child: _emptyHistoryArtboard != null
                                                ? Rive(
                                                    useArtboardSize: true,
                                                    artboard:
                                                        _emptyHistoryArtboard!,
                                                    fit: BoxFit.scaleDown,
                                                  )
                                                : const SizedBox(),
                                          ),
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
                              : Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: AnimatedOpacity(
                                    opacity: isHistory == false ? 0 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOutCirc,
                                    child: ListView.builder(
                                      itemCount: historyItems.length,
                                      itemBuilder: (context, i) {
                                        return Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              _setHistory(i);
                                              isHistory = !isHistory;
                                              historyTrigger?.fire();
                                              setState(() {

                                              });
                                            },
                                            child: Ink(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: const BorderSide(
                                                    color: Color(0xFFC5C5C5),
                                                    width: 1,
                                                  ),
                                                  bottom: i ==
                                                          historyItems.length - 1
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const Flexible(
                                                      child: SizedBox(
                                                    width: 10,
                                                  )),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AutoSizeText(
                                                        historyItems[i]
                                                            ['sourceText'],
                                                        style: const TextStyle(
                                                          fontFamily: 'Slab',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      AutoSizeText(
                                                        historyItems[i]
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
                                  ),
                                )
                          : const SizedBox.shrink(),
                    ],
                  );
                }),
          ),
          _isKeyboardOpen == false
              ? AnimatedOpacity(
                  opacity: isHistory || historyItems.isEmpty ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCirc,
                  onEnd: () {
                    heightInfoFacts = 0;
                  },
                  child: isReady && isHistory == false
                      ? InkWell(
                          onTap: () {
                            showCustomAlertDialog(
                              context,
                              "Интересный факт",
                              () {
                                Navigator.of(context).pop();
                              },
                              Text(
                                facts[randomNumber],
                                style: const TextStyle(
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
                                Image.Image.asset('assets/images/info.png'),
                                const Flexible(
                                  child: SizedBox(
                                    width: 10,
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        child: AutoSizeText(
                                          facts[randomNumber],
                                          minFontSize: 12,
                                          style: TextStyle(
                                            color: textColor,
                                            fontFamily: themeData.textTheme
                                                .bodySmall!.fontFamily,
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
                        )
                      : const SizedBox(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
