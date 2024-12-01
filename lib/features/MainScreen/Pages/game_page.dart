import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/features/Games/alphabet_screen.dart';
import 'package:mans_translate/features/Games/game_word.dart';
import 'package:mans_translate/features/MainScreen/Widgets/Game_Page/cards.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFEEF5FD),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            Container(
              height: 192 + 20 * (size.height / 2400),
              width: MediaQuery.of(context).size.width,
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
            SizedBox(
              height: 10 + 20 * (size.height / 2400),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlphabetScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Ink(
                width: size.width,
                height: 100 + 20 * (size.height / 2400),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                      child: Image.asset('assets/images/alphab.png'),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AutoSizeText(
                              'Алфавит',
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            AutoSizeText(
                              'Изучите написание и произношение Мансийского языка',
                              style: TextStyle(
                                fontFamily: 'Slab',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Русский - Мансийский",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 200 + 20 * (size.height / 2400),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Cards(
                    URLImage: "assets/images/taskwordmans.png",
                    NameTask: "Слова",
                    DescriptionTask: "Выберите правильный вариант перевода",
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameWord(
                            isRussian: true,
                          ),
                        ),
                      );
                    },
                  ),
                  Cards(
                    URLImage: "assets/images/taskfraz.png",
                    NameTask: "Фразы",
                    DescriptionTask: "Составьте из блоков перевод фразы",
                    function: () {},
                  ),
                  Cards(
                    URLImage: "assets/images/taskpredloz.png",
                    NameTask: "Предложения",
                    DescriptionTask: "Напишите перевод предложения",
                    function: () {},
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Майнсийский - Русский",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 200 + 20 * (size.height / 2400),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Cards(
                    URLImage: "assets/images/taskword.png",
                    NameTask: "Слова",
                    DescriptionTask: "Описание",
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameWord(
                            isRussian: false,
                          ),
                        ),
                      );
                    },
                  ),
                  Cards(
                    URLImage: "assets/images/taskfrazmans.png",
                    NameTask: "Фразы",
                    DescriptionTask: "Составьте из блоков перевод фразы",
                    function: () {},
                  ),
                  Cards(
                    URLImage: "assets/images/taskpredlozmans.png",
                    NameTask: "Предложения",
                    DescriptionTask: "Напишите перевод предложения",
                    function: () {},
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
