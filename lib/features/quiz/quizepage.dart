import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/quiz/quizpage_cardwidget.dart';
import 'package:cs_onecup/features/quiz/quizpage_answerlist.dart';
import 'package:cs_onecup/core/constants/config.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizPage extends StatefulWidget {
  final bool redundant;
  String category;
  final int solvedAnswerCnt;

  QuizPage({
    super.key,
    required this.redundant,
    required this.category,
    required this.solvedAnswerCnt,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<Map<String, dynamic>> _cardData;

  @override
  void initState() {
    super.initState();
    _cardData = _fetchCardData();
  }

  Future<Map<String, dynamic>> _fetchCardData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('authToken');
    String url =
        '${Config.baseUrl}/api/cards/card?redundant=${widget.redundant}&category=${widget.category}';
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(utf8.decode(response.bodyBytes))['data'];
      return data;
    } else {
      throw Exception('Failed to load card data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _cardData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PopScope(
              canPop: false,
              child: Container(
                color: AppColors.mainLightGray,
                child: Stack(
                  children: [
                    Positioned(
                      top: 50,
                      left: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/home'));
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.mainDeepOrange,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              height: 4,
                            ),
                            child: Text(
                              '지금까지 푼 문제',
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 50,
                              color: AppColors.mainDeepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                            child: Text(
                              widget.solvedAnswerCnt.toString(),
                            ),
                          ),
                          const DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              height: 4,
                            ),
                            child: Text(
                              '문',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: QuizpageAnswerlist(
                        answerList: snapshot.data!['choice'],
                        redundant: widget.redundant,
                        category: widget.category,
                        quizCategory: snapshot.data!['category'],
                        quizExplanation: snapshot.data!['explanation'],
                        quizAnswer: snapshot.data!['answer'],
                        csv_num: snapshot.data!['csv_number'],
                        solvedAnswerCnt: widget.solvedAnswerCnt,
                      ),
                    ),
                    Center(
                      child: QuizpageCardwidget(
                        heroTag: 'Home_to_Quiz_iconCard',
                        quizCategory: snapshot.data!['category'],
                        quizExplanation: snapshot.data!['question'],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
