import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/core/widgets/cards/answercardwidget.dart';
import 'package:cs_onecup/core/widgets/cards/quizcardwidget.dart';
import 'package:flip_card/flip_card.dart';

import 'package:flutter/material.dart';


class CardDetailsPage extends StatefulWidget {
  final String _quizCategory;
  final String _quizExplanation;
  final String _quizAnswer;
  final String _answerExplanation;

  const CardDetailsPage({
    super.key,
    required String quizCategory,
    required String quizExplanation,
    required String quizAnswer,
    required String answerExplanation})
  :_quizCategory = quizCategory,
   _quizExplanation = quizExplanation,
   _quizAnswer = quizAnswer,
   _answerExplanation = answerExplanation;

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> with SingleTickerProviderStateMixin {
  // 카드 정보



  // 카드 위젯 관련
  bool _isFront = true;
  late AnimationController _controller;
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();
  final _cardScaleFactor = 2.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /** 카드 회전 */
  void flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isFront = !_isFront;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBeige,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainBeige,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new, color: Colors.brown,)),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          // 카드 제목
          Center(
            child: Text("카드 제목",
              style: TextStyle(
                fontSize: 35,
                color: AppColors.mainDeepOrange
              ),
            ),
          ),

          SizedBox(
            height: 8,
          ),

          // 카드
          FlipCard(
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

          SizedBox(
            height: 8,
          ),

          // 레이블 (눌러서 답 보기)
          Text("눌러서 답 보기",
            style: TextStyle(
              color: AppColors.mainDeepOrange,
            ),
            // TODO 투명도
          )


        ],
      ),
    );
  }
}
