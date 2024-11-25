import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';

class QuizpageAnswerlist extends StatefulWidget {
  final String _answerType;
  final List<String> _answerList;

  const QuizpageAnswerlist(
      {super.key, required String answerType, required List<String> answerList})
      : _answerType = answerType,
        _answerList = answerList;

  @override
  State<QuizpageAnswerlist> createState() => _QuizpageAnswerlistState();
}

class _QuizpageAnswerlistState extends State<QuizpageAnswerlist> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget._answerList.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 10, left: BorderSide.strokeAlignCenter),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.mainDeepOrange.withOpacity(0),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.mainDeepOrange,
                width: 2,
              ),
            ),
            child: Text(
              widget._answerList[index],
              style: const TextStyle(
                fontSize: 20,
                color: AppColors.mainDeepOrange,
              ),
            ),
          ),
        );
      }),
    );
  }
}
