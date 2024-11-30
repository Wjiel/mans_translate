
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/MainScreen/Pages/translator_page.dart';
import 'package:mans_translate/features/MainScreen/Widgets/Translator_Page/paste_button.dart';

class CardTranslating extends StatefulWidget {
  CardTranslating({super.key,});

  @override
  State<CardTranslating> createState() => _CardTranslatingState();
}

class _CardTranslatingState extends State<CardTranslating> with ClipboardListener {
  final TextEditingController _textEditingController = TextEditingController();

  final StreamController _copyController = StreamController();

  FocusNode _focus = FocusNode();

  final List<String> _mansiLetters = [
    "ā",
    "ē",
    "ё̄",
    "ӣ",
    "ӈ",
    "о̄",
    "ӯ",
    "ы̄",
    "э̄",
    "ю̄",
    "я̄"
  ];

  void _callback() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null) {
      _textEditingController.text = data.text!;
      _sendTextToAPI();
    }
  }

  void _sendTextToAPI(){
    String _text = _textEditingController.text;
    if(isRussian == true){

    } else {

    }
  }

  Stream _copyStream() {
    clipboardWatcher.addListener(this);
    _checkClipboard();
    return _copyController.stream;
  }

  Future<void> _checkClipboard() async {
    _copyController.add(await Clipboard.hasStrings());
  }

  @override
  Future<void> onClipboardChanged() async {
    ClipboardData? newClipboardData =
    await Clipboard.getData(Clipboard.kTextPlain);
    if(newClipboardData?.text != null && newClipboardData?.text != ""){
      _copyController.add(true);
    }
    else {
      _copyController.add(false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(20),
      decoration: decorationContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              isRussian ? 'Русский' : 'Мансийcкий',
            ),
          ),
          Expanded(
            child: TextField(
              onTapOutside: (tap){
                _focus.unfocus();
              },
              focusNode: _focus,
              controller: _textEditingController,
              onChanged: (text){
                Timer(Duration(seconds: 1), () {
                  if(text == _textEditingController.text){
                    _sendTextToAPI();
                  }
                });
              },
              maxLines: null,
              style: TextStyle(
                fontFamily: themeData.textTheme.bodySmall!.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                hintText: 'Введите текст...',
                hintStyle: TextStyle(
                  color: textColor,
                  fontFamily: themeData.textTheme.bodySmall!.fontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCirc,
            child: Visibility(
              visible: isRussian == true ? false : true,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 43,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      clipBehavior: Clip.hardEdge,
                      itemCount: _mansiLetters.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(left: i == 0? 0 : 15),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              _textEditingController.text += _mansiLetters[i];
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 2),
                                        color: Color(0x40000000),
                                        blurRadius: 8,
                                        spreadRadius: 2)
                                  ]),
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  _mansiLetters[i],
                                  style: const TextStyle(
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: _copyStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }

              return Visibility(
                visible: snapshot.data,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Material(
                    color: Colors.transparent,
                    child: PasteButton(
                      callback: _callback,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
