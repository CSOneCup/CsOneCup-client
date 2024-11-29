import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/home/userprofile.dart';
import 'package:cs_onecup/features/home/solved_and_retry_problem_info.dart';
import 'package:cs_onecup/features/home/cards_in_hand.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int exp = 50;

  String? _selectedCategory = '모든 카테고리'; //선택된 카테고리
  bool _includingSolvedProblems = false; //풀린 문제 포함 여부
  final GlobalKey _checkboxKey = GlobalKey();

  final List<String> _quizCategories = [
    '모든 카테고리',
    '운영체제',
    '네트워크',
    '데이터베이스',
    '자료구조',
    '소프트웨어공학',
    '프로그래밍'
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: AppColors.mainLightGray,
          ),
          child: Column(
            children: [
              UserProfile(userName: '사용자', userLevel: 5, userExp: exp),
              SolvedAndRetryProblemsInfo(
                solvedProblemsToday: 5,
                retryProblems: 12,
              ),
              DropdownButton<String>(
                dropdownColor: AppColors.mainBeige,
                value: _selectedCategory,
                hint: const Text('카테고리 선택'),
                items: _quizCategories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 26),
                child: Row(
                  key: _checkboxKey,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      activeColor: AppColors.mainDeepOrange,
                      value: _includingSolvedProblems,
                      onChanged: (bool? value) {
                        setState(() {
                          _includingSolvedProblems = value!;
                        });
                      },
                    ),
                    Text(
                      '맞춘 문제 포함',
                      style: TextStyle(
                        color: _includingSolvedProblems
                            ? AppColors.mainDeepOrange
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 380,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Image.asset(
                'assets/icons/icon_arrow_up.png',
                width: 30,
                height: 30,
                color: AppColors.mainDeepOrange,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                '랜덤 문제 풀이',
                style: TextStyle(color: AppColors.mainDeepOrange, fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              const CardsInHand(),
            ],
          ),
        ),
      ],
    );
  }
}
