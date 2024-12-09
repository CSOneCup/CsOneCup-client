import 'package:cs_onecup/core/utils/icon_fetcher.dart';
import 'package:cs_onecup/core/widgets/RectangularElevatedButton.dart';
import 'package:cs_onecup/data/models/quizcard.dart';
import 'package:cs_onecup/data/models/quiztype.dart';
import 'package:cs_onecup/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 덱 생성 화면
class DeckCreatePage extends StatefulWidget {
  final int? deckId; // 덱 수정하는 경우 deckId 기입. 덱 생성 시엔 기입 X
  const DeckCreatePage({super.key, this.deckId});

  @override
  State<DeckCreatePage> createState() => _DeckCreatePageState();
}

class _DeckCreatePageState extends State<DeckCreatePage> {
  // TODO API 연결 후 Dismissible ValueKey 수정 (myCards[index], deckCards[index]로)
  late ApiService apiService;
  late SharedPreferences prefs;
  late List<QuizCard> myCards;
  late List<QuizCard> deckCards;
  final _deckTitleController = TextEditingController();
  bool _isLoading = true;

  bool isTitleValid(String title) {
    final t = title.trim();
    return t.isNotEmpty && t.length >= 2;
  }

  /// 생성 버튼 클릭 시 API 전송
  void onCreateButtonPress() async {
    // 제목 validation
    if (!isTitleValid(_deckTitleController.text)) {
      // Toast 메시지 띄우고 return
      Fluttertoast.showToast(
        msg: "덱 제목이 올바르지 않습니다!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    // API 전송 (TODO)
    _deckTitleController.text = '';
    print("${_deckTitleController.text} title is valid.");
    await createDeck(_deckTitleController.text);
  }

  Future<int> createDeck(String title) async {
    // TODO: 덱 생성 안 된 경우
    // 덱 생성하는 경우 (deckId 제공 안된 경우) API 호출해서 새 id 받아옴
    int id = widget.deckId ??
        await apiService.post('api/decks',
            requestBody: {'name': title},
            fromJson: (response) => (response['deck_id'] as int));

    for (var card in deckCards) {
      registerCardToDeck(card.cardId, id);
    }
    return -1;
  }

  /// 덱에 단일 카드 등록
  Future<void> registerCardToDeck(int cardId, int deckId) async {
    Map<String, dynamic> response = await apiService.post('api/cards/deck/add',
        requestBody: {'card_id': cardId, 'deck_id': deckId},
        fromJson: (json) => (json as Map<String, dynamic>));
    print(
        "DeckCreatePage: registered card #${response['card_id']} to $deckId"); // test
  }

  /// pref 및 apiService 초기화
  Future<void> _initialize() async {
    prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('authToken');
    print("jwt: $jwt");
    apiService =
        ApiService(defaultHeader: {'Authorization': 'Bearer $jwt' ?? ''});
  }

  /// 테스트 데이터 삽입. TODO 배포 시 삭제
  Future<void> _fillDummyData() async {
    quizCardGenerator(index) => QuizCard.necessaryArgsConstructor(
        index,
        QuizType.choice,
        "DUMMY_CATEGORY",
        "퀴즈 질문",
        ["선택지1", "선택지2", "선택지3", "선택지4"],
        1,
        "정답 설명");

    myCards = List.generate(10, quizCardGenerator, growable: true);
    deckCards = List.generate(1, quizCardGenerator);
  }

  /// API로 카드 가져옴
  Future<void> _fetchCards() async {
    // 내 카드 검색
    myCards = await apiService.get('api/cards/user',
        fromJson: (jsonArray) => (jsonArray as List<dynamic>)
            .map((json) => QuizCard.fromJson(json as Map<String, dynamic>))
            .toList());
    print("DeckCreatePage: fetched my cards ");
    for (var c in myCards) print(c); // test

    // 덱 내 카드 검색
    if (widget.deckId != null) {
      deckCards = await apiService.get('api/decks/${widget.deckId}/cards',
          fromJson: (response) =>
              (response['cards'] as List<Map<String, dynamic>>)
                  .map((json) => QuizCard.fromJson(json))
                  .toList());
      print("DeckCreatePage: fetched deck cards");
      for (var c in deckCards) print(c); // test
    } else {
      deckCards = [];
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchApiData() async {
    print("DeckCreatePage: INITIALIZING");
    await _initialize();
    await _fetchCards();
    // await _fillDummyData(); // TODO 테스트 용, 배포 시 삭제
  }

  @override
  void initState() {
    super.initState();
    _fetchApiData();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TextField 바깥 누르면 텍스트필드 포커스 해제
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: AppColors.mainBeige,

          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.mainBeige,
            leading: IconButton(onPressed: (){ Navigator.pop(context); }, icon: const Icon(Icons.arrow_back_ios_new, color: Colors.brown,)),
          ),

          body: Column(
            children: [
              const Center(
                child: Text("덱 생성",
                  style: TextStyle(
                      fontSize: 35,
                      color: AppColors.mainDeepOrange
                  ),
                ),
              ),

              SizedBox(
                width: 300,
                child: TextField(
                  controller: _deckTitleController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "덱 제목",
                      hintStyle: TextStyle(
                        fontSize: 18, // 힌트 글자 크기
                        color: Colors.deepOrange.withOpacity(0.5), // 힌트 글자 색
                        fontWeight: FontWeight.w400, // 힌트 글자 굵기
                      ),
                      border: InputBorder.none
                  ),
                ),
              ),

              const SizedBox(height: 8,),

              _isLoading
                  ? const CircularProgressIndicator()
                  : Expanded(
                child: Row(
                  children: [

                    // 덱 나열
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              const Text("나의 덱", style: TextStyle(fontSize: 16, color: Colors.deepOrange),),
                              const SizedBox(height: 8,),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: deckCards.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: ValueKey(deckCards[index]),
                                        child: SimpleCardTileSmall(
                                          index: index,
                                          title: deckCards[index].title,
                                          category: deckCards[index].category,
                                          csCard: deckCards[index],
                                          onTap: (){}, // TODO
                                        ),
                                        onDismissed: (direction) {
                                          // 덱 카드 Dismiss 시 나의 카드에 추가
                                          setState(() {
                                            myCards.add(deckCards.removeAt(index));
                                            print("deck: ${deckCards.length}");
                                            print("myCards: ${myCards.length}");
                                          });
                                        },
                                      );
                                    }
                                ),
                              )
                            ],
                          ),
                        )
                    ),

                    // 카드 목록 나열
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                              children: [
                                const Text("카드 목록", style: TextStyle(fontSize: 16, color: Colors.deepOrange),),
                                const SizedBox(height: 8,),
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: myCards.length,
                                        itemBuilder: (context, index) {
                                          return Dismissible(
                                            key: ValueKey(myCards[index]),
                                            child: SimpleCardTileSmall(
                                              index: index,
                                              title: myCards[index].title,
                                              category: myCards[index].category,
                                              csCard: myCards[index],
                                              onTap: (){},
                                            ),
                                            onDismissed: (direction) {
                                              setState(() {
                                                // 나의 카드 Dismiss 시 덱에 추가
                                                deckCards.add(myCards.removeAt(index));
                                              });
                                            },
                                          );
                                        }
                                    )
                                )
                              ]
                          ),
                        )
                    ),

                  ],
                ),
              ),

              // 하단 버튼 영역
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: RectangularElevatedButton(
                      onPressed: onCreateButtonPress,
                      borderRadius: 8,
                      child: const Text("덱 생성", style: TextStyle(fontSize: 20, color: Colors.white),),
                      backgroundColor: AppColors.mainDeepOrange,
                    ),
                  )
              ),
            ],
          )
      ),
    );
  }
}

/// 카드 타일 위젯
class SimpleCardTileSmall extends StatelessWidget {
  final int index;
  final String title;
  final String category;
  final VoidCallback? onTap;
  final QuizCard? csCard;

  const SimpleCardTileSmall({
    super.key,
    required this.index,
    title,
    category,
    csCard,
    this.onTap,
  })  : title = title ?? '아주 긴 카드 제목 12345',
        category = category ?? 'None',
        csCard = csCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // 바깥 컨테이너 (흰 색)
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white, // 배경색 (필요에 따라 수정)

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // 그림자 위치
              ),
            ],
          ),

          child: Padding(
            // 내부 컨테이너 (베이지색)
            padding: const EdgeInsets.all(5), // 흰 테두리 두꼐
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBeige,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                // 리스트 타일
                children: [
                  // 아이콘
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        IconFetcher.fetchImage(category, width: 20, height: 20),
                  ),

                  // 제목
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
