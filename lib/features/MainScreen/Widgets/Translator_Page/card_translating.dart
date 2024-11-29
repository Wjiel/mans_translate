
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/MainScreen/Pages/translator_page.dart';
import 'package:mans_translate/features/MainScreen/Widgets/Translator_Page/paste_button.dart';

class CardTranslating extends StatelessWidget {
  CardTranslating({super.key,});

  TextEditingController _textEditingController = TextEditingController();

  void _callback()async {
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


  @override
  Widget build(BuildContext context) {
    return Ink(
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
              style:const TextStyle(
                fontFamily: 'Serif',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              isRussian ? 'Русский' : 'Мансийcкий',
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextField(
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
              ],
            ),
          ),
          StreamBuilder(
            stream: streamVisib.strims,
            builder: (context, snapshot) {
              if (!snapshot.hasData || streamVisib.thereClipBordText == false) {
                return const SizedBox();
              }

              return Visibility(
                visible: streamVisib.thereClipBordText,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: PasteButton(callback: _callback,),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
