import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/Config/ThemesData/themes_data.dart';
import 'package:mans_translate/features/StartScreen/start_screen.dart';
import 'package:mans_translate/features/Widgets/custom_eleveted_button.dart';
import 'package:rive/rive.dart';

class HelloPage extends StatefulWidget {
   HelloPage({super.key});

  @override
  State<HelloPage> createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  final String text1 = 'Привет! Я - медведица Мантра.\n\n';

  final String text2 =
      'Мои друзья(народ Манси) находятся в беде! Их древнейший язык с каждым днем все ближе к исчезновению, и именно ты можешь помочь спасти его!';

  Artboard? _helloArtboard;

  SMITrigger? helloTrigger;

  StateMachineController? helloStateMachineController;

  void _helloAnim() {
    rootBundle.load('assets/animations/helloAnim.riv').then(
          (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        helloStateMachineController =
            StateMachineController.fromArtboard(artboard, "State Machine 1");
        if (helloStateMachineController != null) {
          artboard.addController(helloStateMachineController!);
          helloTrigger = helloStateMachineController!.findSMI('Trigger 1');

          for (var e in helloStateMachineController!.inputs) {

          }
          helloTrigger = helloStateMachineController!.inputs.first as SMITrigger;
        }

        setState(() => _helloArtboard = artboard);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _helloAnim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: _helloArtboard != null ? Rive(
                useArtboardSize: true,
                artboard: _helloArtboard!,
                fit: BoxFit.scaleDown,
              ) : SizedBox(),
            ),
            const Spacer(flex: 9),
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
              text: "Но как? Я его не знаю(",
              function: () {
                pageControllerStart.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutExpo,
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
