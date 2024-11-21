import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';

class QuizCardwidget extends StatelessWidget {
  final double scaleFactor;

  const QuizCardwidget({super.key, this.scaleFactor = 1.0});

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("CS One Cup", style: TextStyle(fontSize: 18)),
                Image.asset('assets/icons/icon_card.png',
                    width: 115, height: 115),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
