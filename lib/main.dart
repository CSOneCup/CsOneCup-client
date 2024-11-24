//import 'package:cs_onecup/features/auth/landingpage.dart';
import 'package:cs_onecup/features/auth/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:cs_onecup/features/main/mainpage.dart';

void main() {
  runApp(const MyApp());
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
      home: const LandingPage(),
    );
  }
}
