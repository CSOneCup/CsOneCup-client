import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/deckQuiz/deckquiz_bundle.dart';

//TODO 나중에 deckCode 받아서 quizlist 받아온 다음 문제풀이 페이지에 전송하기

class Deckquizpage extends StatefulWidget {
  final bool _isRetry;
  final String _deckName;
  final String _deckHashTag;
  final int _deckLength;
  final Map _deckCategoryInfo = {
    '운영체제': 35,
    '네트워크': 10,
    '데이터베이스': 5,
    '자료구조': 10,
    '소프트웨어공학': 10,
    '프로그래밍': 30,
  };

  Deckquizpage({
    super.key,
    bool? isRetry,
    required String deckName,
    required String deckHashTag,
    required int deckLength,
  })  : _isRetry = isRetry ?? false,
        _deckName = deckName,
        _deckHashTag = deckHashTag,
        _deckLength = deckLength;

  @override
  State<Deckquizpage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<Deckquizpage> {
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
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/icon_arrow_up.png',
                    width: 70,
                    height: 70,
                    color: AppColors.mainDeepOrange,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('퀴즈를 시작하려면 드로우하세요',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.mainDeepOrange,
                      )),
                ],
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: DeckquizBundle(
                deckName: widget._deckName,
                deckHashTag: widget._deckHashTag,
                deckLength: widget._deckLength,
                deckCategoryInfo: widget._deckCategoryInfo,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
