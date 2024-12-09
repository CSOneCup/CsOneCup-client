import "package:cs_onecup/data/services/api_service.dart";
import "package:cs_onecup/features/deck/carddetailspage.dart";
import 'package:flutter/material.dart';
import "package:cs_onecup/core/constants/colors.dart";
import "package:cs_onecup/features/deck/widgets/simplecardtile.dart";
import "package:cs_onecup/data/models/quizcard.dart";
import "package:shared_preferences/shared_preferences.dart";


class DeckDetailsPage extends StatefulWidget {
  final int deckId;
  const DeckDetailsPage({super.key, required this.deckId});
  @override
  State<DeckDetailsPage> createState() => _DeckDetailsPageState();
}

class _DeckDetailsPageState extends State<DeckDetailsPage> {

  late SharedPreferences pref;
  late ApiService apiService;
  late List<QuizCard> _cards;
  late String? _deckTitle;

  late Future<dynamic>? _future;
  
  void editDeck() {
    // TODO
  }
  
  void shareDeck() {
    // TODO 확인 창 띄우고 공유
  }

  /// pref 및 apiService 초기화
  Future<void> _initialize() async {
    pref = await SharedPreferences.getInstance();
    String? jwt = pref.getString('authToken');
    apiService = ApiService(defaultHeader: {'Authorization': "Bearer $jwt" ?? ''});
  }

  /// 덱 카드 가져오기
  Future<bool> _fetchCards() async {
    final response = await apiService.get(
        'api/decks/${widget.deckId}/cards',
        fromJson: (json) => (json)
    );
    final cards = (response['cards'] as List<dynamic>)
            .map((cardJson) => QuizCard.fromJson(cardJson as Map<String, dynamic>))
            .toList();


    for(var card in cards) print(card); // test

    setState(() {
      _deckTitle = response['deck_info']['name'];
      _cards = cards;
    });
    print("DeckDetailsPage: fetched deck named ${_deckTitle}");
    return true;
  }

  Future<bool> _fetchApiData() async {
    await _initialize();
    await _fetchCards();
    return true;
  }

  @override
  void initState() {
    super.initState();
    _future = _fetchApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainLightGray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainLightGray,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.mainDeepOrange),
          onPressed: () {
            // 뒤로가기 버튼 동작
            Navigator.pop(context);
          }
        ),
      ),

      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if(snapshot.hasData == false) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 15),
                ),
              );
            } else {
              return Column(
                children: [
                  // 덱 제목 & 카드 수
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          _deckTitle ?? '나의 덱',
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.normal,
                            color: AppColors.mainDeepOrange,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${_cards.length} cards",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.mainDeepOrange.withOpacity(0.5)),
                        ),
                        const SizedBox(height: 45,)
                      ],
                    ),
                  ),

                  _cards.isEmpty
                  // 카드 빈 경우 텍스트 출력
                      ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("덱이 비었습니다!", style: TextStyle(fontSize: 36,),),
                  )
                  // 카드 리스트 출력
                      : Expanded(
                      child: ListView.builder(
                          itemCount: _cards.length,
                          itemBuilder: (context, index) => SimpleCardTile(
                            index: index,
                            title: _cards[index].title,
                            category: _cards[index].category,
                            card: _cards[index],
                            onTap: (quizCard) {
                              print("tapped card $index (name: ${quizCard.title}");
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => CardDetailsPage(
                                      cardTitle: quizCard.title,
                                      quizCategory: quizCard.category,
                                      quizExplanation: quizCard.question,
                                      quizAnswer: quizCard.choice[quizCard.answer - 1],
                                      answerExplanation: quizCard.explanation))
                              );
                            },
                          )
                      )
                  )
                ],
              );
            }
          }
      ),


    );
  }
}

