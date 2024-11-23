import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:cs_onecup/core/widgets/cards/iconcardwidget.dart';
import 'package:cs_onecup/core/widgets/cards/quizcardwidget.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  final _scaleFactor = 2.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.mainLightGray,
      child: Center(
          child: SizedBox(
        width: 170 * _scaleFactor,
        height: 285 * _scaleFactor,
        child: Hero(
          tag: 'Home_to_Quiz_iconCard',
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL,
            side: CardSide.FRONT,
            front: IconCardwidget(
              scaleFactor: _scaleFactor,
            ),
            back: QuizCardwidget(
              scaleFactor: _scaleFactor,
              quizCategory: '소프트웨어공학',
              quizExplanation: '운영체제가 제공하는 기능에 해당하지 않는 것은 무엇인가요?',
            ),
          ),
        ),
      )),
    );
  }
}
