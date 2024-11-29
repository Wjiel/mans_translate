import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';

class PasteButton extends StatefulWidget {
  final void Function()? callback;
  const PasteButton({super.key, this.callback});

  @override
  State<PasteButton> createState() => _PasteButtonState();
}

class _PasteButtonState extends State<PasteButton> {
  final double radius = 20;

  String text = 'Вставить';

  String textAnim = '';

  void StartAnim() {
    int count = 0;
    textAnim = '';
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      textAnim += text[count];
      count++;
      setState(() {});
      if (count == text.length) timer.cancel();
    });
  }

  @override
  void initState() {
    super.initState();

    StartAnim();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
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
              textAnim,
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
