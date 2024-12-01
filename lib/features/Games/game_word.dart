import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';
import 'package:mans_translate/features/Games/Widgets/answer_container.dart';
import 'package:mans_translate/features/Widgets/custom_eleveted_button.dart';

class GameWord extends StatelessWidget {
  bool isRussian;
  GameWord({super.key, required this.isRussian});

  Map<String, dynamic> _gameMap = {
    "sourceText": "Дом",
    "correctAnswer": "Кол",
    "secondAnswer": "Кин",
    "thirdAnswer": "Кас"
  };

  void _isCorrect(context, text) {
    if(text != _gameMap["correctAnswer"]){
      showModalBottomSheet(
          context: context,
          isDismissible: false,
          builder: (context) {
            return ModalSheetWrong(correctAnswer: _gameMap["correctAnswer"],);
          });
    } else {
      showModalBottomSheet(
          context: context,
          isDismissible: false,
          builder: (context) {
            return const ModalSheetSuccessful();
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEF5FD),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const AutoSizeText(
                'Выберите правильный перевод',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Slab',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 2),
              AutoSizeText(
                _gameMap["sourceText"],
                minFontSize: 30,
                style: const TextStyle(
                  color: Color(0xFF0AA10F),
                  fontFamily: 'Slab',
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Divider(
                color: Color(0xFF7B7B7B),
              ),
              const Spacer(flex: 5),
              AnswerContainer(
                text: _gameMap["secondAnswer"],
                function: () {
                  _isCorrect(context, _gameMap["secondAnswer"]);
                },
              ),
              AnswerContainer(
                text: _gameMap["correctAnswer"],
                function: () {
                  _isCorrect(context, _gameMap["correctAnswer"]);
                },
              ),
              AnswerContainer(
                text: _gameMap["thirdAnswer"],
                function: () {
                  _isCorrect(context, _gameMap["thirdAnswer"]);
                },
              ),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          color: shadow,
                        )
                      ],
                    ),
                    width: size.width,
                    height: 40 + 30 * (size.width / 1080),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xFF434343),
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: AutoSizeText(
                              "Вернуться назад",
                              style: TextStyle(
                                color: Color(0xFF434343),
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ModalSheetSuccessful extends StatelessWidget {
  const ModalSheetSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      height: size.height * 0.27,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Color(0xFF2DC73F),
              ),
              SizedBox(
                width: 10,
              ),
              AutoSizeText(
                'Верно!',
                style: TextStyle(
                  fontFamily: 'Serif',
                  color: Color(0xFF2DC73F),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          const AutoSizeText(
            'Вы дали правильный ответ и получили 1xp.',
            style: TextStyle(
              fontFamily: 'Slab',
              color: Color(0xFF2DC73F),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(flex: 3),
          CustomElevetedButton(
            color: const Color(0xFF2DC73F),
            text: 'Продолжить',
            function: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            radius: 50,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class ModalSheetWrong extends StatelessWidget {
  final String correctAnswer;
  const ModalSheetWrong({super.key, required this.correctAnswer});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      height: size.height * 0.28,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.cancel,
                color: Color(0xFFC72D2D),
              ),
              SizedBox(
                width: 10,
              ),
              AutoSizeText(
                'Неверно!',
                style: TextStyle(
                  fontFamily: 'Serif',
                  color: Color(0xFFC72D2D),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          const AutoSizeText(
            'Правильный ответ: ',
            style: TextStyle(
              fontFamily: 'Slab',
              color: Color(0xFFC72D2D),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
           AutoSizeText(
            correctAnswer,
            style: TextStyle(
              fontFamily: 'Slab',
              color: Color(0xFFC72D2D),
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(flex: 5),
          CustomElevetedButton(
            color: const Color(0xFFC72D2D),
            text: 'Продолжить',
            function: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            radius: 50,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
