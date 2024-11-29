import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import '../../data/models/deck.dart';

class DeckDetailPage extends StatelessWidget {
  final int deckId;

  DeckDetailPage({super.key, required this.deckId});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('DeckDetailPage'),
      ),
    );
  }
}