import 'package:cs_onecup/core/utils/icon_fetcher.dart';
import 'package:cs_onecup/core/widgets/RectangularElevatedButton.dart';
import 'package:cs_onecup/data/models/quizcard.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 덱 생성 화면
class DeckCreatePage extends StatefulWidget {

  const DeckCreatePage({super.key});

  @override
  State<DeckCreatePage> createState() => _DeckCreatePageState();
}

class _DeckCreatePageState extends State<DeckCreatePage> {
  // TODO 내 카드 = API로 가져오기
  // TODO API 연결 후 Dismissible ValueKey 수정 (myCards[index], deckCards[index]로)
  List<QuizCard> myCards = [];
  List<QuizCard> deckCards = [];
  final _deckTitleController = TextEditingController();

  bool isTitleValid(String title) {
    final t = title.trim();
    return t.isNotEmpty && t.length >= 2;
  }

  void onCreateButtonPress() {
    // 제목 validation
    if(!isTitleValid(_deckTitleController.text)){
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
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   borderSide: const BorderSide(
                  //     color: Colors.orange, // 포커스 시 테두리 색상
                  //     width: 1.0,
                  //   ),
                  // ),
                ),
              ),
            ),

            const SizedBox(height: 8,),

            Expanded(
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
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: ValueKey(index), // TODO API 연결 후 deckCards[index]로 변경
                                  child: SimpleCardTileSmall(index: index),
                                  onDismissed: (direction) {
                                    // 덱 카드 Dismiss 시 나의 카드에 추가
                                    setState(() {
                                      myCards.add(deckCards.removeAt(index));
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
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: ValueKey(index), // TODO myCards[index]로 변경
                                        child: SimpleCardTileSmall(index: index),
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
  }): this.title = title ?? '아주 긴 카드 제목 12345',
      this.category = category ?? 'None',
      this.csCard = csCard;



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
                    child: IconFetcher.fetchImage(category, width: 20, height: 20),
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

                  const SizedBox(width: 10,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
