import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/MainScreen/main_screen.dart';
import 'package:mans_translate/features/Widgets/custom_eleveted_button.dart';
import 'package:rive/rive.dart';

class SeccondPage extends StatelessWidget {
  const SeccondPage({super.key});

  final String text1 = 'Поверь, это не сложно, я помогу!\n\n';
  final String text2 =
      'Я могу переводить с русского на мансийский и наоборот. А также могу в игровой форме научить тебя делать это самому!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF5FD),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 5),
            SizedBox(
              height: 250,
              width: 250,
              child: RiveAnimation.asset(
                'assets/animations/happyAnim.riv',
                fit: BoxFit.fitHeight,
              ),
            ),
            AutoSizeText.rich(
              minFontSize: 1,
              TextSpan(
                children: [
                  TextSpan(
                    text: text1,
                    style: themeData.textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: text2,
                    style: themeData.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomElevetedButton(
              color: Primary,
              text: "Хорошо, начнем!",
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
              },
              radius: 40,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
