import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/home/userprofile.dart';
import 'package:cs_onecup/features/home/solved_and_retry_problem_info.dart';
import 'package:cs_onecup/features/home/cards_in_hand.dart';

import '../../core/constants/config.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  final String _name = '';
  final int _level = 0;
  final int _expPoints = 0;

  final List<String> _quizCategories = [
    '모든 카테고리',
    '운영체제',
    '네트워크',
    '데이터베이스',
    '자료구조',
    '소프트웨어공학',
    '프로그래밍'
  ];

  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = _fetchUserData();
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('authToken');
    const String url = '${Config.baseUrl}/api/user/info';
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['data'];
      return data;
    } else {
      throw Exception('Failed to load user data');
    }
  }

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
          child: FutureBuilder<Map<String, dynamic>>(
            future: _userData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final data = snapshot.data!;
                final String name = data['name'];
                final int level = data['level'];
                final int expPoints = data['exp_point'];
                return UserProfile(
                    userLevel: level, userName: name, userExp: expPoints);
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
        Positioned(
          top: 200,
          left: 0,
          right: 0,
          child: Column(
            children: [
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
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/icons/icon_arrow_up.png',
                width: 40,
                height: 40,
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
              CardsInHand(
                redundant: _includingSolvedProblems,
                category: _selectedCategory ?? 'all',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
