//import 'package:cs_onecup/features/auth/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/features/main/mainpage.dart';

import 'package:cs_onecup/DeckBuildingPage/deckdetailspage.dart';

void main() {
  // runApp(const MyApp());
  runApp(const DeckDetailsPage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CsOneCup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}
