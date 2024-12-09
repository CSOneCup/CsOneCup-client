import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/answer/answerpage.dart';

import '../../core/constants/config.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizpageAnswerlist extends StatefulWidget {
  final bool redundant;
  String category;
  final String quizCategory;
  final String quizExplanation;
  final int quizAnswer;
  final int csv_num;
  final int solvedAnswerCnt;

  final List<dynamic> _answerList;

  QuizpageAnswerlist({
    super.key,
    required List<dynamic> answerList,
    required this.redundant,
    required this.category,
    required this.quizCategory,
    required this.quizExplanation,
    required this.quizAnswer,
    required this.csv_num,
    required this.solvedAnswerCnt,
  }) : _answerList = answerList;

  @override
  State<QuizpageAnswerlist> createState() => _QuizpageAnswerlistState();
}

class _QuizpageAnswerlistState extends State<QuizpageAnswerlist> {
  String selectedAnswer = '';
  final double _answerAreaWidth = 330; //카드 사이즈 맞춤
  final double _answerAreaHeight = 430; //카드 사이즈 맞춤
  late double _answerBoxMinHeight;
  late double _answerFontSize;
  late FontWeight _answerFontWeight;

  late String _answerString;

  int _selectedAnswerIndex = -1;

  @override
  void initState() {
    if (widget._answerList.length < 3) {
      _answerBoxMinHeight = 100;
      _answerFontSize = 100;
      _answerFontWeight = FontWeight.bold;
    } else {
      _answerBoxMinHeight = 80;
      _answerFontSize = 25;
      _answerFontWeight = FontWeight.normal;
    }

    _answerString = widget._answerList[widget.quizAnswer - 1];

    super.initState();
  }

  Future<void> _getCard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('authToken');
    const String url = '${Config.baseUrl}/api/cards/user/add';
    final body = jsonEncode({
      "csv_num": widget.csv_num,
    });

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _answerAreaWidth,
      height: _answerAreaHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text('두 번 클릭해서 제출',
              style: TextStyle(fontSize: 20, color: AppColors.mainDeepOrange)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget._answerList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        if (_selectedAnswerIndex == index) {
                          //선택한 답이 또 클릭되면 제출

                          final bool isCorrect =
                              _selectedAnswerIndex == widget.quizAnswer - 1;

                          //정답 시 로직
                          if (isCorrect) {
                            _getCard();
                          }

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AnswerPage(
                                redundant: widget.redundant,
                                category: widget.category,
                                quizCategory: widget.quizCategory,
                                quizExplanation: widget.quizExplanation,
                                quizAnswer: _answerString,
                                isCorrect: isCorrect,
                                solvedAnswerCnt: widget.solvedAnswerCnt,
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            _selectedAnswerIndex = index;
                          });
                        }
                      },
                      child: Container(
                        width: _answerAreaWidth,
                        constraints: BoxConstraints(
                          minHeight: _answerBoxMinHeight,
                        ),
                        decoration: index == _selectedAnswerIndex
                            ? BoxDecoration(
                                color: AppColors.mainDeepOrange.withOpacity(1),
                                borderRadius: BorderRadius.circular(20),
                              )
                            : BoxDecoration(
                                color: AppColors.mainDeepOrange.withOpacity(0),
                              ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget._answerList[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: _answerFontSize,
                                fontWeight: _answerFontWeight,
                                color: index == _selectedAnswerIndex
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
