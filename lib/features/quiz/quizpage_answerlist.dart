import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/answer/answerpage.dart';

class QuizpageAnswerlist extends StatefulWidget {
  final bool redundant;
  String category;
  final String quizCategory;
  final String quizExplanation;
  final int quizAnswer;

  final List<dynamic> _answerList;

  QuizpageAnswerlist({
    super.key,
    required List<dynamic> answerList,
    required this.redundant,
    required this.category,
    required this.quizCategory,
    required this.quizExplanation,
    required this.quizAnswer,
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AnswerPage(
                                redundant: widget.redundant,
                                category: widget.category,
                                quizCategory: widget.quizCategory,
                                quizExplanation: widget.quizExplanation,
                                quizAnswer: _answerString,
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
