import 'package:cs_onecup/features/quiz/quizepage.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/answer/answerpage_cardwidget.dart';

class AnswerPage extends StatefulWidget {
  final bool redundant;
  String category;
  final String quizCategory;
  final String quizExplanation;
  final String quizAnswer;
  final bool isCorrect;

  AnswerPage({
    super.key,
    required this.redundant,
    required this.category,
    required this.quizCategory,
    required this.quizExplanation,
    required this.quizAnswer,
    required this.isCorrect,
  });

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final int _solvedAnswerCnt = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PopScope(
        canPop: false,
        child: Container(
          color: AppColors.mainLightGray,
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName('/home'));
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
                        '지금까지 푼 문제',
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
                        _solvedAnswerCnt.toString(),
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
              Positioned(
                bottom: 150,
                right: 0,
                left: 0,
                child: Center(
                  child: SizedBox(
                    width: 330,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainDeepOrange,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuizPage(
                                    redundant: widget.redundant,
                                    category: widget.category)));
                      },
                      child: const Text(
                        '다음 문제',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: widget.isCorrect
                    ? const Icon(
                        Icons.trip_origin,
                        color: AppColors.lightGreen,
                        size: 150,
                      )
                    : const Text(
                        'X',
                        style: TextStyle(
                          color: AppColors.lightRed,
                          fontSize: 150,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              Center(
                child: AnswerpageCardwidget(
                  quizCategory: widget.quizCategory,
                  quizExplanation: widget.quizExplanation,
                  quizAnswer: widget.quizAnswer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
