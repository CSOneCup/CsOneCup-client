import 'dart:convert';

import 'package:cs_onecup/data/models/deck.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../deck/deckdetailspage.dart';
import 'package:http/http.dart' as http;

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final _deckSearchController = TextEditingController();
  final String url = "http://141.164.52.130:8082";

  List? _totalDeckList;
  List? _recommendedDeckList;
  List? _popularDeckList;
  List? _searchResultDeckList;

  bool _isLoading = true;

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
      _totalDeckList = [];
      _searchResultDeckList = [];
      _recommendedDeckList = await _loadDecksData();
      _popularDeckList = await _loadDecksData();
    // _totalDeckList = await _loadDecksData();
    //
    // if(_totalDeckList!.isNotEmpty) {
    //   _searchResultDeckList = [];
    //
    //   for(int i = 0; i < _totalDeckList!.length; i++) {
    //     if(i % 2 == 0) {
    //       _recommendedDeckList?.add(_totalDeckList![i]);
    //     } else {
    //       _popularDeckList?.add(_totalDeckList![i]);
    //     }
    //   }
    // } else {
    //   _searchResultDeckList = [];
    //   _recommendedDeckList = [];
    //   _popularDeckList = [];
    // }

    setState(() {
      _isLoading = false;
    });
  }

  Future<List?> _loadDecksData() async {
    String requestUrl = "$url/api/decks/random3";
    final sharedPreference = await SharedPreferences.getInstance();
    final jwtToken = sharedPreference.getString('authToken');

    try {
      final response = await http.get(
        Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
        List listData = responseData['data']['decks'] ?? [];
        List deckList = [];

        listData.forEach((data) {
          deckList.add(Deck.necessaryArgsConstructor(data['deck_id'], data['owner']['name'], data['name']));
        });

        return deckList;
      }
    } catch(e) {
      print(e);
      return null;
    }
    return null;
  }

  List<Deck> searchDeckList(String searchText) {
    List<Deck> deckList = <Deck>[];

    // 덱 이름 기반 필터링
    _totalDeckList?.where((deck) {
      if (deck.name == searchText ||
          deck.name.toString().contains(searchText)) {
        return true;
      } else {
        return false;
      }
    }).forEach((deck) => deckList.add(deck));

    // 덱 태그 기반 필터링
    _totalDeckList?.where((deck) {
      if (deck.tags.toString().contains(searchText) &&
          !deckList.contains(deck)) {
        return true;
      } else {
        return false;
      }
    }).forEach((deck) => deckList.add(deck));

    return deckList;
  }

  @override
  void dispose() {
    _deckSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width * 0.8;
    double paddingWidth = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      backgroundColor: AppColors.mainDeepOrange,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'COMMUNITY',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '다른 유저가 올린 퀴즈 덱을 풀어보세요!',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  )
                ],
              ),
            ),

            _isLoading ? const CircularProgressIndicator() :
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: AppColors.mainLightGray,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28)), // 둥근 모서리
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, left: paddingWidth, right: paddingWidth),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                              image: AssetImage('assets/icons/icon_star.png')),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '오늘의 추천 덱',
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.mainDeepOrange,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)), // 둥근 모서리
                        ),
                        child: Container(
                          width: widgetWidth,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _recommendedDeckList?.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Container(
                                  width: widgetWidth / 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Center(
                                          child: Image.asset('assets/images/recommend_deck.png', width: 70, height: 90,)
                                        ),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => DeckDetailsPage(deckId: _recommendedDeckList?[index].deckId),
                                          ));
                                        },
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: Text(_recommendedDeckList?[index].name, style: TextStyle(fontWeight: FontWeight.bold),)
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                              image: AssetImage(
                                  'assets/icons/icon_gold_medal.png')),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '인기 덱',
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.mainDeepOrange,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 150,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)), // 둥근 모서리
                          ),
                          child: SizedBox(
                            width: widgetWidth,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _popularDeckList?.length,
                              itemBuilder: (context, index) {
                                  return Container(
                                    width: widgetWidth / 3,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            child: Center(
                                                child: Image.asset(
                                              'assets/images/popular_deck.png',
                                              width: 70,
                                              height: 90,
                                            )),
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => DeckDetailsPage(deckId: _popularDeckList?[index].deckId,),
                                              ));
                                            },
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(_popularDeckList?[index].name, style: TextStyle(fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                      ),
                      const SizedBox(
                        height: 65,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
