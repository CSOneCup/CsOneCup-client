import 'package:flutter/material.dart';
import "package:cs_onecup/core/constants/colors.dart";
import "package:cs_onecup/features/deck/widgets/simplecardtile.dart";
import "package:cs_onecup/data/models/quizcard.dart";


class DeckDetailsPage extends StatefulWidget {
  const DeckDetailsPage({super.key});
  @override
  State<DeckDetailsPage> createState() => _DeckDetailsPageState();
}

class _DeckDetailsPageState extends State<DeckDetailsPage> {

  // TODO API 연결
  List<QuizCard> cards = [];
  
  void editDeck() {
    // TODO
  }
  
  void shareDeck() {
    // 확인 창 띄우고 공유
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainLightGray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainLightGray,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.mainDeepOrange),
          onPressed: () {
            // 뒤로가기 버튼 동작
            Navigator.pop(context);
          }
        ),
        actions: [
          TextButton(
            onPressed: editDeck,
            child: const Text(
              "편집",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.mainDeepOrange
              ),
            ),
          ),
          TextButton(
            onPressed: shareDeck,
            child: const Text(
              "공유",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.mainDeepOrange
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // 덱 제목 & 카드 수
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "나의 덱 이름",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.normal,
                    color: AppColors.mainDeepOrange,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "18 cards",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.mainDeepOrange.withOpacity(0.5)),
                ),
                SizedBox(height: 45,)
              ],
            ),
          ),
          // 카드 리스트
          Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) => SimpleCardTile(index: index)
              )
          )
        ],
      )
    );
  }
}

