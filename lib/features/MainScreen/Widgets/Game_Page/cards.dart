import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String URLImage;
  final String NameTask;
  final String DescriptionTask;
  Function function;
  Cards({
    super.key,
    required this.URLImage,
    required this.NameTask,
    required this.DescriptionTask,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double radius = 10;
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          function();
        },
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          height: size.height,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF9F9F9F),
                    ),
                    image: DecorationImage(
                      image: AssetImage(URLImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(radius),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      NameTask,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Serif',
                      ),
                    ),
                    AutoSizeText(
                      DescriptionTask,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Slab',
                        color: Color(0xFF424242),
                      ),
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
