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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          deckName,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                    height: 20,
                  ),
                  Text(
                    deckHashTag,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.mainDeepOrange,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        deckLength.toString(),
                        style: const TextStyle(
                          color: AppColors.mainDeepOrange,
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '문제',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          height: 3,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: deckCategoryInfo.entries.map<Widget>((entry) {
                        return CategoryRateWidget(
                          categoryName: entry.key,
                          categoryRate: entry.value,
                        );
                      }).toList(),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class CategoryRateWidget extends StatelessWidget {
  final String _categoryName;
  final int _categoryRate;
  const CategoryRateWidget(
      {super.key, required String categoryName, required int categoryRate})
      : _categoryName = categoryName,
        _categoryRate = categoryRate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 8),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: AppColors.mainDeepOrange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Text(
                _categoryName,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppColors.mainLightGray,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                '$_categoryRate%',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
