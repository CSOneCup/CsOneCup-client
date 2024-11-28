import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';

class DeckquizInfoCardwidget extends StatelessWidget {
  final double scaleFactor;
  late String deckName;
  late String deckHashTag;
  late int deckLength;
  late Map deckCategoryInfo;

  DeckquizInfoCardwidget({
    super.key,
    this.scaleFactor = 1.0,
    required this.deckName,
    required this.deckHashTag,
    required this.deckLength,
    required this.deckCategoryInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
          width: 170 * scaleFactor,
          height: 285 * scaleFactor,
          child: Card(
            color: const Color(0xFFF4F4F4),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(15)),
            ),
          )),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (11 * scaleFactor), vertical: (11 * scaleFactor)),
        child: SizedBox(
          width: 148 * scaleFactor,
          height: 263 * scaleFactor,
          child: Card(
            color: AppColors.cardBeige,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          '카테고리',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/icons/icon_questionQ.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Expanded(
                    child: Text(
                      '설명',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
