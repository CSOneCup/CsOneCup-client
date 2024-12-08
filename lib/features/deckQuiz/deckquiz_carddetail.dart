import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/core/widgets/cards/answercardwidget.dart';
import 'package:cs_onecup/core/widgets/cards/quizcardwidget.dart';
import 'package:flip_card/flip_card.dart';

import 'package:flutter/material.dart';

class DeckquizCarddetail extends StatefulWidget {
  final String _cardTitle;
  final String _quizCategory;
  final String _quizExplanation;
  final String _quizAnswer;
  final String _answerExplanation;

  const DeckquizCarddetail(
      {super.key,
      required String cardTitle,
      required String quizCategory,
      required String quizExplanation,
      required String quizAnswer,
      required String answerExplanation})
      : _cardTitle = cardTitle,
        _quizCategory = quizCategory,
        _quizExplanation = quizExplanation,
        _quizAnswer = quizAnswer,
        _answerExplanation = answerExplanation;

  @override
  State<DeckquizCarddetail> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<DeckquizCarddetail> {
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
    return Scaffold(
      backgroundColor: AppColors.mainLightGray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainLightGray,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.brown,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OX_widget(
              isCorrect: false,
              quizAnswer: widget._quizAnswer,
            ),
            // 카드 제목
            Center(
              child: Text(
                widget._cardTitle,
                style: const TextStyle(
                    fontSize: 24, color: AppColors.mainDeepOrange),
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
                      quizExplanation: widget._quizExplanation),
                  back: AnswerCardwidget(
                      scaleFactor: _cardScaleFactor,
                      quizAnswer: widget._quizAnswer,
                      answerExplanation: widget._answerExplanation)),
            ),

            const SizedBox(height: 8),

            // 레이블 (눌러서 답 보기)
            Text(
              "눌러서 답 보기",
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

class OX_widget extends StatelessWidget {
  final bool _isCorrect;
  final String _quizAnswer;

  const OX_widget(
      {super.key, required bool isCorrect, required String quizAnswer})
      : _isCorrect = isCorrect,
        _quizAnswer = quizAnswer;

  @override
  Widget build(BuildContext context) {
    if (_isCorrect) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGreen, width: 4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IntrinsicWidth(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.trip_origin,
                  color: AppColors.lightGreen,
                  size: 35,
                ),
                const SizedBox(width: 8),
                Text(
                  _quizAnswer,
                  style: const TextStyle(
                    fontSize: 35,
                    color: AppColors.lightGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightRed, width: 4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IntrinsicWidth(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'X',
                  style: TextStyle(
                    color: AppColors.lightRed,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _quizAnswer,
                  style: const TextStyle(
                    fontSize: 35,
                    color: AppColors.lightRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
