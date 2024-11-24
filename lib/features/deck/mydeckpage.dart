import 'package:cs_onecup/features/deck/deckcreatepage.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import '../../data/models/deck.dart';
import 'deckdetailpage.dart';

class MyDeckPage extends StatefulWidget {
  const MyDeckPage({super.key});

  @override
  State<MyDeckPage> createState() => _MyDeckPageState();
}

class _MyDeckPageState extends State<MyDeckPage> {
  final _deckSearchController = TextEditingController();
  final List _originalDeckList = <Deck>[
    Deck(0, '선호', '테스트 덱 1', 3),
    Deck(1, '재훈', '테스트 덱 2', 3),
    Deck(2, '재환', '테스트 덱 3', 3),
    Deck(3, '혁진', '테스트 덱 4', 3),
  ]; // 실제 데이터
  List _deckList = <Deck>[
    Deck(0, '선호', '테스트 덱 1', 3),
    Deck(1, '재훈', '테스트 덱 2', 3),
    Deck(2, '재환', '테스트 덱 3', 3),
    Deck(3, '혁진', '테스트 덱 4', 3),
  ];
  final String _searchText = '';

  int countListLength() {
    if (_deckList.length % 3 == 0) {
      return _deckList.length ~/ 3;
    }

    return _deckList.length ~/ 3 + 1;
  }

  List searchDeckList(String searchText) {
    List<Deck> deckList = <Deck>[];

    // 덱 이름 기반 필터링
    _originalDeckList.where((deck) {
      if (deck.getDeckName() == searchText ||
          deck.getDeckName().toString().contains(searchText)) {
        return true;
      } else {
        return false;
      }
    }).forEach((deck) => deckList.add(deck));

    // 덱 태그 기반 필터링
    _originalDeckList.where((deck) {
      if (deck.getTagList().toString().contains(searchText) &&
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
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: buttonWidth / 16, right: buttonWidth / 16, top: 5, bottom: 5),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: _deckSearchController,
                cursorColor: AppColors.mainDeepOrange,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  fillColor: AppColors.mainDeepOrange,
                  prefixIconColor: AppColors.mainDeepOrange,
                  suffixIconColor: AppColors.mainDeepOrange,
                  focusColor: AppColors.mainDeepOrange,
                  hintText: '검색어를 입력해주세요',
                  hintStyle: const TextStyle(
                    fontSize: 15,
                    color: AppColors.mainDeepOrange),
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.mainDeepOrange,
                      width: 1.5
                    ),
                  ),
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
                    _deckList = searchDeckList(text);
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.4,
                mainAxisSpacing: 5,
                crossAxisSpacing: 0.5
              ),
              itemCount: _deckList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        child: const Image(
                          image: AssetImage('assets/images/emptyDeck.png')
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DeckDetailPage(deckId: _deckList[index].deckId),
                          ));
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(_deckList[index].name)
                    ],
                  ),
                );
              }
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DeckCreatePage()));
        },
        tooltip: 'Create Deck',
        backgroundColor: AppColors.mainDeepOrange,
        foregroundColor: Colors.white,
        elevation: 25,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 30,),
      ),
    );
  }
}
