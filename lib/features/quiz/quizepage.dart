import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:cs_onecup/core/widgets/cards/iconcardwidget.dart';
import 'package:cs_onecup/core/widgets/cards/quizcardwidget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _scaleFactor = 2.0;

  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    // 일정 시간이 지난 후 카드를 뒤집음
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_cardKey.currentState != null && _cardKey.currentState!.isFront) {
        _cardKey.currentState!.toggleCard();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.mainLightGray,
      child: Center(
          child: Hero(
        tag: 'Home_to_Quiz_iconCard',
        child: FlipCard(
          key: _cardKey,
          direction: FlipDirection.HORIZONTAL,
          side: CardSide.FRONT,
          flipOnTouch: false,
          front: IconCardwidget(
            scaleFactor: _scaleFactor,
          ),
          back: QuizCardwidget(
            scaleFactor: _scaleFactor,
            quizCategory: '소프트웨어공학',
            quizExplanation: '운영체제가 제공하는 기능에 해당하지 않는 것은 무엇인가요?',
          ),
        ),
      )),
    );
  }
}
