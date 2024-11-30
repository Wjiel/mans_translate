import 'package:flutter/material.dart';
import 'package:mans_translate/features/Widgets/custom_eleveted_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Widget? content;
  const CustomAlertDialog({super.key, required this.title, this.onPressed, this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      title: SizedBox(width: MediaQuery.of(context).size.width,
          child: Text(title,
            style: TextStyle(
              fontFamily: "Serif",
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),
          ),),
      content: content,
      actions: <Widget>[
        CustomElevetedButton(
            color: Color(0xFF0AA10F),
            text: "Буду знать!",
            function: () {
              Navigator.of(context).pop();
            },
            radius: 30,
        ),
      ],
    );
  }
}

Future showCustomAlertDialog(BuildContext context, String title, void Function()? onPressed, Widget? content) async {
  return showDialog(context: context,useRootNavigator: false, builder: (context) {
    return CustomAlertDialog(title: title, onPressed: onPressed, content: content,);
  });
}