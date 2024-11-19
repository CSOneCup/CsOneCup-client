import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import '../../data/models/deck.dart';

class DeckCreatePage extends StatelessWidget {
  const DeckCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class MyDeckPage extends StatefulWidget {
  const MyDeckPage({super.key});

  @override
  State<MyDeckPage> createState() => _MyDeckPageState();
}

class _MyDeckPageState extends State<MyDeckPage> {
  final _deckSearchController = TextEditingController();
  final List _originalDeckList = <Deck>[]; // 실제 데이터
  List _deckList = <Deck>[];
  final String _searchText = '';

  int countListLength() {
    if (_deckList.length % 3 == 0) {
      return _deckList.length ~/ 3;
    }

    return _deckList.length ~/ 3 + 1;
  }

  List searchDeckList(String searchText) {
    List deckList = <Deck>[];

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
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _deckSearchController,
            cursorColor: AppColors.mainDeepOrange,
            decoration: InputDecoration(
                hintText: '검색어를 입력해주세요',
                hintStyle: const TextStyle(
                    fontSize: 12, color: AppColors.mainDeepOrange),
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onChanged: (text) {
              setState(() {
                _deckList = searchDeckList(text);
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: countListLength(),
                itemBuilder: (c, i) {
                  return Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'images/empty_deck.png',
                            width: 50,
                            height: 60,
                          ),
                          Text(
                            _deckList[i * 3].getDeckName(),
                            style: const TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'images/empty_deck.png',
                            width: 50,
                            height: 60,
                          ),
                          Text(
                            _deckList[i * 3 + 1].getDeckName(),
                            style: const TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'images/empty_deck.png',
                            width: 50,
                            height: 60,
                          ),
                          Text(
                            _deckList[i * 3 + 2].getDeckName(),
                            style: const TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DeckCreatePage()));
        },
        tooltip: 'Create Deck',
        child: const Icon(
          Icons.add,
          size: 20,
        ),
      ),
    );
  }
}
