import 'package:cs_onecup/core/utils/icon_fetcher.dart';
import 'package:cs_onecup/data/models/quizcard.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';


/// 카드 타일 위젯
class SimpleCardTile extends StatelessWidget {
  final int index;
  final String title;
  final String category;
  final void Function(QuizCard)? onTap; // 아마 카드 상세 페이지 띄우게 하기
  final QuizCard card;

  const SimpleCardTile({
    super.key,
    required this.index,
    String? title,
    String? category,
    required this.card,
    this.onTap
  })
  : this.title = title ?? '카드 제목',
    this.category = category ?? 'None';

  @override
  Widget build(BuildContext context) {
    print(onTap);
    return GestureDetector(
      onTap: (onTap != null) ? (){onTap!(card);} : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Container(
          // 바깥 컨테이너 (흰색)
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2.5),
          ),
          child: Padding(
            // 내부 컨테이너 (베이지색);
            padding: const EdgeInsets.all(4.0), // 흰 테두리 두꼐
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBeige,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                // 아이콘
                leading: IconFetcher.fetchImage(category, width: 30, height: 30),
                // 제목
                title: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 25,
                      color: AppColors.mainDeepOrange,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}