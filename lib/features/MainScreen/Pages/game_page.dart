import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/features/MainScreen/Widgets/Game_Page/cards.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 192 + 20 * (MediaQuery.of(context).size.height / 2400),
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: RichText(
                      text: const TextSpan(
                          text: "5",
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0AA10F),
                            fontFamily: 'Slab',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\nУровень",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Slab',
                              ),
                            ),
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: VerticalDivider(
                      color: Color(0xFF7B7B7B),
                    ),
                  ),
                  const Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              "Решено слов",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Serif',
                              ),
                            ),
                            AutoSizeText(
                              "10",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Serif',
                                color: Primary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              "Решено фраз",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Serif',
                              ),
                            ),
                            AutoSizeText(
                              "10",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Serif',
                                color: Primary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              "Решено предложений",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Serif',
                              ),
                            ),
                            AutoSizeText(
                              "10",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Serif',
                                color: Primary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              "Место в топе",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Serif',
                              ),
                            ),
                            AutoSizeText(
                              "10",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Serif',
                                color: Primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Text("С русского"),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  Cards(
                    URLImage: "assets/images/taskword.png",
                    NameTask: "Слова",
                    DescriptionTask: "Описание",
                  ),
                  Cards(
                    URLImage: "da",
                    NameTask: "Слова",
                    DescriptionTask: "Описание",
                  ),
                  Cards(
                    URLImage: "da",
                    NameTask: "Слова",
                    DescriptionTask: "Описание",
                  ),
                ],
              ),
            ),
            const Text("С мансийского"),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  Cards(
                    URLImage: "da",
                    NameTask: "Слова",
                    DescriptionTask: "Описание",
                  ),
                  Cards(
                    URLImage: "da",
                    NameTask: "Слова",
                    DescriptionTask: "Описание",
                  ),
                  Cards(
                    URLImage: "da",
                    NameTask: "Слова",
                    DescriptionTask: "Описание",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
