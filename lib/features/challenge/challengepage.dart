import 'package:cs_onecup/data/models/deck.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import '../deck/deckdetailspage.dart';


class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final _deckSearchController = TextEditingController();
  final List<Deck> _totalDeckList = <Deck>[
    Deck(0, '선호', '테스트 덱 1', 3),
    Deck(1, '재훈', '테스트 덱 2', 3),
    Deck(2, '재환', '테스트 덱 3', 3),
    Deck(3, '혁진', '테스트 덱 4', 3),
  ];
  List<Deck> _recommendedDeckList = <Deck>[
    Deck(0, '선호', '테스트 덱 1', 3),
    Deck(1, '재훈', '테스트 덱 2', 3),
    Deck(2, '재환', '테스트 덱 3', 3),
    Deck(3, '혁진', '테스트 덱 4', 3),
  ];
  List<Deck> _popularDeckList = <Deck>[
    Deck(0, '선호', '테스트 덱 1', 3),
    Deck(1, '재훈', '테스트 덱 2', 3),
    Deck(2, '재환', '테스트 덱 3', 3),
    Deck(3, '혁진', '테스트 덱 4', 3),
  ];
  List<Deck> _searchResultDeckList = <Deck>[
    // Deck(0, '선호', '테스트 덱 1', 3),
    // Deck(1, '재훈', '테스트 덱 2', 3),
    // Deck(2, '재환', '테스트 덱 3', 3),
    // Deck(3, '혁진', '테스트 덱 4', 3),
  ];

  List<Deck> searchDeckList(String searchText) {
    List<Deck> deckList = <Deck>[];

    // 덱 이름 기반 필터링
    _totalDeckList.where((deck) {
      if (deck.name == searchText ||
          deck.name.toString().contains(searchText)) {
        return true;
      } else {
        return false;
      }
    }).forEach((deck) => deckList.add(deck));

    // 덱 태그 기반 필터링
    _totalDeckList.where((deck) {
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
  void initState() {
    // API로 데이터 받아와서 저장
    super.initState();
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
              padding: EdgeInsets.only(top: 10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('CHALLENGE', style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.w500),),
                  Text('다른 유저가 올린 퀴즈 덱을 풀어보세요!', style: TextStyle(fontSize: 13, color: Colors.white),)
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: AppColors.mainLightGray,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)), // 둥근 모서리
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0, left: paddingWidth, right: paddingWidth),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(image: AssetImage('assets/icons/icon_star.png')),
                          SizedBox(width: 5,),
                          Text('오늘의 추천 덱', style: TextStyle(fontSize: 20, color: AppColors.mainDeepOrange, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 125,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)), // 둥근 모서리
                        ),
                        child: GridView.builder(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 0.5,
                            crossAxisSpacing: 0.5
                          ),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Stack(
                                      key: UniqueKey(),
                                      children: [
                                        Center(
                                          child: Image.asset('assets/images/recommend_deck.png', width: 70, height: 90,)
                                        ),
                                      ]
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => DeckDetailsPage(),
                                      ));
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(_recommendedDeckList[index].name, style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            );
                          }
                        )
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(image: AssetImage('assets/icons/icon_gold_medal.png')),
                          SizedBox(width: 5,),
                          Text('인기 덱', style: TextStyle(fontSize: 20, color: AppColors.mainDeepOrange, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 130,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)), // 둥근 모서리
                          ),
                          child: GridView.builder(
                              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 0.5,
                                  crossAxisSpacing: 0.5
                              ),
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: Stack(
                                            key: UniqueKey(),
                                            children: [
                                              Center(
                                                  child: Image.asset('assets/images/popular_deck.png', width: 70, height: 90,)
                                              ),
                                            ]
                                        ),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => DeckDetailsPage(),
                                          ));
                                        },
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(_popularDeckList[index].name, style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                );
                              }
                          )
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.mainDeepOrange,
                          elevation: 10,
                          shadowColor: AppColors.mainDeepOrange,
                        ),
                        child: Container(
                          width: widgetWidth * 0.38,
                          height: 35,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/icons/icon_rocket.png')),
                              SizedBox(width: 10,),
                              Text('빠른 시작', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('덱 검색', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(
                          controller: _deckSearchController,
                          cursorColor: AppColors.mainDeepOrange,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                            fillColor: AppColors.mainDeepOrange,
                            prefixIconColor: Colors.black,
                            suffixIconColor: Colors.black,
                            focusColor: AppColors.mainDeepOrange,
                            hintText: '검색어를 입력해주세요',
                            hintStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey),
                            suffixIcon: const Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: AppColors.mainDeepOrange,
                                  width: 2.0
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            setState(() {
                              _searchResultDeckList = searchDeckList(text);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: widgetWidth,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _searchResultDeckList.isEmpty ?
                        const Center(child: Text('검색 결과 없음', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),)) :
                        ListView.builder(
                          itemCount: _searchResultDeckList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_searchResultDeckList[index].name),
                            );
                          }
                        )
                      ),
                      const SizedBox(
                        height: 20,
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
