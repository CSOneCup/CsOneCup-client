import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/home/userprofile.dart';
import 'package:cs_onecup/features/home/solved_and_retry_problem_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int exp = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.mainLightGray,
        child: Column(
          children: [
            UserProfile(userName: '사용자', userLevel: 5, userExp: exp),
            SolvedAndRetryProblemsInfo(
              solvedProblemsToday: 5,
              retryProblems: 12,
            ),
          ],
        ));
  }
}
