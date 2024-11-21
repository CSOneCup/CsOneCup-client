import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';

class SolvedAndRetryProblemsInfo extends StatefulWidget {
  int solvedProblemsToday;
  int retryProblems;

  SolvedAndRetryProblemsInfo(
      {super.key,
      required this.solvedProblemsToday,
      required this.retryProblems});

  @override
  State<SolvedAndRetryProblemsInfo> createState() =>
      _SolvedAndRetryProblemsInfoState();
}

class _SolvedAndRetryProblemsInfoState
    extends State<SolvedAndRetryProblemsInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      const Text('오늘 푼 문제', style: TextStyle(fontSize: 16)),
                      Text(
                        '${widget.solvedProblemsToday}',
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                  width: 80,
                  child: VerticalDivider(
                    color: AppColors.mainBeige,
                    thickness: 3,
                    width: 40,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      const Text('재도전 할 문제', style: TextStyle(fontSize: 16)),
                      Text(
                        '${widget.retryProblems}',
                        style: const TextStyle(fontSize: 25),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.lightRed, // 텍스트 색상
                            minimumSize: const Size(100, 30), // 버튼의 최소 크기
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0), // 패딩
                            textStyle: const TextStyle(fontSize: 15), // 텍스트 스타일
                          ),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('오답 재도전'),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                )
                              ])),
                    ],
                  ),
                )
              ]),
        ],
      ),
    );
  }
}
