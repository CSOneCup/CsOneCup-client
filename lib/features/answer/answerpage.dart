import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/answer/answerpage_cardwidget.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({super.key});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final int _solvedAnswerCnt = 7;

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
                  Navigator.of(context).popUntil(ModalRoute.withName('/home'));
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
            const Center(
              child: AnswerpageCardwidget(
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
