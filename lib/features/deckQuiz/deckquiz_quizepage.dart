import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/quiz/quizpage_cardwidget.dart';
import 'package:cs_onecup/features/deckQuiz/deckquiz_answerlist.dart';

class DeckquizQuizpage extends StatefulWidget {
  final int _remainingQuestions;

  const DeckquizQuizpage({super.key, required int remainingQuestions})
      : _remainingQuestions = remainingQuestions;

  @override
  State<DeckquizQuizpage> createState() => _QuizPageState();
}

class _QuizPageState extends State<DeckquizQuizpage> {
  //정답 선택 시 실행 함수
  void _onAnswerSelected() {
    setState(() {
      //남은 문제 수 감소
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DeckquizQuizpage(
            remainingQuestions: (widget._remainingQuestions - 1),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.mainLightGray,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  //Navigator.of(context).popUntil(ModalRoute.withName('/home'));
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.mainDeepOrange,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      height: 4,
                    ),
                    child: Text(
                      '남은 문제 20문 중',
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 50,
                      color: AppColors.mainDeepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(
                      widget._remainingQuestions.toString(),
                    ),
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      height: 4,
                    ),
                    child: Text(
                      '문',
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: DeckquizAnswerlist(
                answerList: const [
                  '메모리 관리',
                  'TLB(Translation)',
                  '애플리케이션 개발',
                  '프로세스 종료 시 데이터가 자동 삭제됩니다',
                ],
                onAnswerSubmitted: _onAnswerSelected,
              ),
            ),
            const Center(
              child: QuizpageCardwidget(
                heroTag: 'deck_to_Quiz_IconCard',
                quizCategory: '소프트웨어공학',
                quizExplanation: '운영체제가 제공하는 기능에 해당하지 않는 것은 무엇인가요!',
              ),
            )
          ],
        ),
      ),
    );
  }
}
