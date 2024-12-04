import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/core/widgets/cards/quizcardwidget.dart';
import 'package:cs_onecup/data/models/quizcard.dart';
import 'package:cs_onecup/data/models/quiztype.dart';
// import 'package:cs_onecup/data/services/api_service.dart';
import 'package:cs_onecup/features/deck/widgets/simplequizcard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 카드 나열 페이지
class CardListPage extends StatefulWidget {

  const CardListPage({super.key});

  @override
  State<CardListPage> createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  // late ApiService apiService;
  late SharedPreferences pref;
  final List<QuizCard> _dummyCards = List.generate(10, (index) => QuizCard.allArgsConstructor(
      index,
      QuizType.choice,
      '제목 $index',
      'DUMMY_CATEGORY',
      '퀴즈 $index',
      [], // choice
      1,
      // 설명
      '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789'
    )
  );
  
  late List<QuizCard> _myCards;

  String truncate(String s, int limit) {
    return '${s.substring(0, limit-3)}...';
  }

  void onQuizCardTap(int index) {
    print("card touch $index");
  }

  /// pref 및 apiService 초기화
  /*
  Future<void> _initialize() async {
    pref = await SharedPreferences.getInstance();
    String? jwt = await pref.getString('authToken');
    apiService = ApiService(defaultHeader: {'Authorization': jwt ?? ''});
  }
  
  /// Card 가져오기
  Future<void> _fetchData() async {
    _myCards = await apiService.get(
        'api/cards/user',
        fromJson: (jsonList) => jsonList
                                .map((json) => QuizCard.fromJson(json))
                                .toList());
    _myCards.forEach((c) {
      print(c); // test
    });
  }
  
  @override
  void initState() {
    super.initState();
    _initialize().then((_) {
      _fetchData();
    });
    // API 호출하는 다른 함수
  }*/

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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 검색창
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "검색어를 입력해 주세요",
                  hintStyle: const TextStyle(
                    fontSize: 14, // 글자 크기
                    color: AppColors.mainDeepOrange, // 색상
                  ),
                  prefixIcon: const Icon(Icons.search, color: AppColors.mainDeepOrange,),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.mainDeepOrange, width: 1.0), // 포커스 시 테두리 색
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.mainDeepOrange, width: 1.0), // 기본 테두리 색
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32,),

            // 필터 버튼 (dummy)
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.mainDeepOrange,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text("  카테고리 |            ", style: TextStyle(color: AppColors.mainDeepOrange),),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 카드 Grid View 나열
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: _dummyCards.length, // 카드 개수
                  // itemCount: _myCards.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 가로 2개
                    crossAxisSpacing: 4.0, // 가로 간격
                    mainAxisSpacing: 8.0, // 세로 간격
                    childAspectRatio: 0.7, // 카드 비율 (너비 대비 높이)
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onQuizCardTap(index),
                      child: SimpleQuizCard(
                        // quizCategory: _myCards[index].category,
                        // quizExplanation: _myCards[index].explanation,
                        quizCategory: _dummyCards[index].category,
                        quizExplanation: truncate(_dummyCards[index].explanation, 60),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
