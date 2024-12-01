import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mans_translate/Config/Colors/colors_data.dart';

class AlphabetScreen extends StatelessWidget {
  AlphabetScreen({super.key});

  final List<String> alph = [
    'А',
    'А̄',
    'Б',
    'В',
    'Г',
    'Д',
    "Е",
    'Е̄',
    'Ё',
    'Ё̄',
    'Ж',
    'З',
    'И',
    'Ӣ',
    'Й',
    'К',
    'Л',
    'М',
    'Н',
    'Ӈ',
    'О',
    'О̄',
    'П',
    'Р',
    'С',
    'Т',
    'У',
    'Ӯ',
    'Ф',
    'Х',
    'Ц',
    'Ч',
    'Ш',
    'Щ',
    'Ъ',
    'Ы',
    'Ы̄',
    'Ь',
    'Э',
    'Э̄',
    'Ю',
    'Ю̄',
    'Я',
    'Я̄'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF5FD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const AutoSizeText(
                'Давай изучать алфавит мансийского языка!',
                style: TextStyle(
                  fontFamily: 'Slab',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 50,
                  ),
                  itemCount: alph.length,
                  itemBuilder: (context, i) {
                    return Material(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: shadow,
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: Center(
                            child: AutoSizeText(
                              alph[i],
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
