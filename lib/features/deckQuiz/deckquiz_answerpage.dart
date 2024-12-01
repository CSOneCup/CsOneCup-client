import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';

class DeckquizAnswerPage extends StatelessWidget {
  const DeckquizAnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          color: AppColors.mainLightGray,
          width: double.infinity,
          height: double.infinity,
          child: const Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '정답 확인 페이지',
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
