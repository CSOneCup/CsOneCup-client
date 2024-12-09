import 'dart:convert';

import 'package:cs_onecup/features/deck/deckcreatepage.dart';
import 'package:cs_onecup/features/deck/deckdetailspage.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/deck.dart';
import 'package:http/http.dart' as http;

class MyDeckPage extends StatefulWidget {
  const MyDeckPage({super.key});

  @override
  State<MyDeckPage> createState() => _MyDeckPageState();
}

class _MyDeckPageState extends State<MyDeckPage> {
  final _deckSearchController = TextEditingController();
  final String url = "http://141.164.52.130:8082";
  List? _originalDeckList;
  List? _deckList;
  String? _searchText;

  bool _isLoading = true;

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    _originalDeckList = await _loadUserDeck();
    _deckList = await _loadUserDeck();
    _deckList = _deckList ?? [];
    setState(() {
      _isLoading = false;
    });
  }

  Future<List?> _loadUserDeck() async {
    String requestUrl = "$url/api/user/info";
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
        final Map<String, dynamic> responseData =
            jsonDecode(utf8.decode(response.bodyBytes));
        final String userName = responseData['data']['name'];
        List listData = responseData['data']['decks'];
        List deckList = [];

        for (var data in listData) {
          deckList.add(Deck(data['deck_id'], userName, data['name'],
              data['number_of_cards']));
        }

        return deckList;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  int countListLength() {
    if (_deckList!.length % 3 == 0) {
      return _deckList!.length ~/ 3;
    }

    return _deckList!.length ~/ 3 + 1;
  }

  List<Deck> searchDeckList(String searchText) {
    List<Deck> deckList = <Deck>[];

    // 덱 이름 기반 필터링
    _originalDeckList?.where((deck) {
      if (deck.name == searchText ||
          deck.name.toString().contains(searchText)) {
        return true;
      } else {
        return false;
      }
    }).forEach((deck) => deckList.add(deck));

    // 덱 태그 기반 필터링
    _originalDeckList?.where((deck) {
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
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      body: Container(
        color: AppColors.mainLightGray,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: buttonWidth / 16,
                  right: buttonWidth / 16,
                  top: 5,
                  bottom: 5),
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
                        fontSize: 15, color: AppColors.mainDeepOrange),
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.mainDeepOrange, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.mainDeepOrange, width: 2.0),
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
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1 / 1.4,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 0.5),
                        itemCount: _deckList?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                GestureDetector(
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/images/deck_image.png'),
                                    width: 80,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DeckDetailsPage(
                                              deckId: _deckList?[index].deckId),
                                          //   builder: (context) => DeckDetailsPage()    // 재환이가 짠 페이지로 연결
                                        ));
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(_deckList?[index].name)
                              ],
                            ),
                          );
                        })),
          ],
        ),
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
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
