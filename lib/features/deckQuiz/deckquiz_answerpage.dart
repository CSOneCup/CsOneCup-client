import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import "package:cs_onecup/features/deck/widgets/simplecardtile.dart";
import 'deckquiz_scoreball.dart';
import 'deckquiz_carddetail.dart';
import 'deckquiz_simplecardtile.dart';

class DeckquizAnswerPage extends StatelessWidget {
  final int score = 98;
  final int total = 20;
  final int correct = 17;

  final bool isCorrect = false;

  const DeckquizAnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainLightGray,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.mainLightGray,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: AppColors.mainDeepOrange),
              onPressed: () {
                // 뒤로가기 버튼 동작 (덱 문제 -> 덱 퀴즈 상세 -> 홈 or 덱 리스트)
                for (int i = 0; i < 3; i++) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
              }),
          title: const Text("점수",
              style: TextStyle(color: AppColors.mainDeepOrange)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            DeckquizScoreball(score: score, total: total, correct: correct),
            const SizedBox(
              height: 20,
            ),
            // 카드 리스트
            Expanded(
                child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) => Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            isCorrect
                                ? const Icon(
                                    Icons.trip_origin,
                                    color: AppColors.lightGreen,
                                    size: 50,
                                  )
                                : const Text(
                                    'X',
                                    style: TextStyle(
                                      color: AppColors.lightRed,
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DeckquizCarddetail(
                                          cardTitle: "카드 제목",
                                          quizCategory: "소프트웨어공학",
                                          quizExplanation: "카드에 대한 설명",
                                          quizAnswer: "문제 정답",
                                          answerExplanation: "정답에 대한 해설",
                                        ),
                                      ),
                                    );
                                  },
                                  child: DeckquizSimplecardtile(index: index)),
                            ),
                          ],
                        )))
          ],
        ));
  }
}
