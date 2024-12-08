import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';

class DeckquizScoreball extends StatelessWidget {
  final int score;
  final int total;
  final int correct;

  const DeckquizScoreball({
    super.key,
    required this.score,
    required this.total,
    required this.correct,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 300,
        height: 300,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.mainDeepOrange,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: const Stack(
          children: [
            Center(
              child: Text(
                "100",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 0,
              left: 0,
              child: Text(
                "17/20",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
