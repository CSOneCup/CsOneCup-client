import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/core/widgets/cards/answercardwidget.dart';
import 'package:cs_onecup/core/widgets/cards/quizcardwidget.dart';
import 'package:cs_onecup/data/models/quizcard.dart';
import 'package:flip_card/flip_card.dart';

import 'package:flutter/material.dart';


class CardDetailsPage extends StatefulWidget {
  final String _cardTitle;
  final String _quizCategory;
  final String _quizExplanation;
  final String _quizAnswer;
  final String _answerExplanation;

  const CardDetailsPage({
    super.key,
    required String cardTitle,
    required String quizCategory,
    required String quizExplanation,
    required String quizAnswer,
    required String answerExplanation})
  :_cardTitle = cardTitle,
   _quizCategory = quizCategory,
   _quizExplanation = quizExplanation,
   _quizAnswer = quizAnswer,
   _answerExplanation = answerExplanation;

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  // 카드 위젯 관련
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();
  final _cardScaleFactor = 2.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Gesture Detector Tap");
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.mainBeige,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.mainBeige,
          leading: IconButton(onPressed: (){ Navigator.pop(context); }, icon: const Icon(Icons.arrow_back_ios_new, color: Colors.brown,)),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            // 카드 제목
            Center(
              child: Text(widget._cardTitle,
                style: const TextStyle(
                  fontSize: 24,
                  color: AppColors.mainDeepOrange
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 카드
            SizedBox(
              width: 300,
              height: 500,
              child: FlipCard(
                key: _cardKey,
                direction: FlipDirection.HORIZONTAL,
                side: CardSide.FRONT,
                front: QuizCardwidget(
                  scaleFactor: _cardScaleFactor,
                  quizCategory: widget._quizCategory,
                  quizExplanation: widget._quizExplanation
                ),
                back: AnswerCardwidget(
                  scaleFactor: _cardScaleFactor,
                  quizAnswer: widget._quizAnswer,
                  answerExplanation: widget._answerExplanation
                )
              ),
            ),

            const SizedBox(height: 8),

            // 레이블 (눌러서 답 보기)
            Text("눌러서 답 보기",
              style: TextStyle(
                fontSize: 24,
                color: AppColors.mainDeepOrange.withOpacity(0.3),
              ),
            )


          ],
        ),
      ),
    );
  }
}
