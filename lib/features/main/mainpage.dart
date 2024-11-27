import 'package:cs_onecup/features/deck/decklistpage.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/features/home/homepage.dart';
import 'package:cs_onecup/features/deck/mydeckpage.dart';
import 'package:cs_onecup/features/challenge/challengepage.dart';
import 'package:cs_onecup/features/ranking/rankingpage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: const <Widget>[
            HomePage(),
            DeckListPage(),
            ChallengePage(),
            RankingPage(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 7,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: const Color(0xFFE1752F),
                unselectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/icon_mainPage.png',
                      width: 40,
                      color:
                          _index == 0 ? const Color(0xFFE1752F) : Colors.black,
                    ),
                    label: '메인',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/icon_deckPage.png',
                      width: 45,
                      color:
                          _index == 1 ? const Color(0xFFE1752F) : Colors.black,
                    ),
                    label: '덱 구성',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/icon_challengePage.png',
                      width: 40,
                      color:
                          _index == 2 ? const Color(0xFFE1752F) : Colors.black,
                    ),
                    label: '챌린지',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/icon_rankingPage.png',
                      width: 40,
                      color:
                          _index == 3 ? const Color(0xFFE1752F) : Colors.black,
                    ),
                    label: '랭킹',
                  ),
                ],
                currentIndex: _index,
                onTap: (int index) {
                  setState(() {
                    _index = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
