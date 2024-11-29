import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/deck/cardlistpage.dart';
import 'package:cs_onecup/features/deck/mydeckpage.dart';
import 'package:flutter/material.dart';

class DeckListPage extends StatefulWidget {
  const DeckListPage({super.key});

  @override
  State<DeckListPage> createState() => _DeckListPageState();
}

class _DeckListPageState extends State<DeckListPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CS 한 잔', style: TextStyle(fontSize: 22, color: AppColors.mainDeepOrange),),
          actions: [
            IconButton(onPressed: () { }, icon: const Icon(Icons.settings_outlined, size: 30,))
          ],
          bottom: const TabBar(
            tabAlignment: TabAlignment.fill,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.mainDeepOrange, width: 3.0)
              )
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.grey,
            labelColor: AppColors.mainDeepOrange,
            tabs: [
              Tab(
                child: Text('나의 덱', style: TextStyle(fontSize: 20),),

              ),
              Tab(child: Text('카드 목록', style: TextStyle(fontSize: 20),),)
            ]),
          toolbarHeight: 50,
        ),
        body: const TabBarView(
          children: [
            Tab(
              child: MyDeckPage(),
            ),
            Tab(
              child: CardListPage(),
            )
          ]
        ),
      ),
    );
  }
}
