import 'package:cs_onecup/LandingPage/landingpage.dart';
import 'package:flutter/material.dart';
import 'MainPage/mainpage.dart';

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
      title: 'CS 한잔',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}
