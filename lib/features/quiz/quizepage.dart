import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/quiz/quizpage_cardwidget.dart';
import 'package:cs_onecup/features/quiz/quizpage_answerlist.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
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
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.mainDeepOrange,
                ),
              ),
            ),
            const Positioned(
              bottom: 30,
              left: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    child: Text(
                      '지금까지 푼 문제',
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 50,
                      color: AppColors.mainDeepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(
                      '7',
                    ),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    child: Text(
                      '문',
                    ),
                  ),
                ],
              ),
            ),
            const Center(
              child: QuizpageAnswerlist(
                answerList: ['O', 'X'],
              ),
            ),
            const Center(
              child: QuizpageCardwidget(
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
