import "package:flutter/material.dart";

class DeckDetailsPage extends StatefulWidget {
  const DeckDetailsPage({super.key});

  @override
  State<DeckDetailsPage> createState() => _DeckDetailsPageState();
}

class _DeckDetailsPageState extends State<DeckDetailsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("TO BE DEVELOPED"),
      ),
    );
  }
}

/**
 *  Expanded(
    child: ListView.builder(
    itemCount: 10, // 카드 개수
    itemBuilder: (context, index) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    child: ListTile(
    leading: Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
    color: Colors.grey[300],
    borderRadius: BorderRadius.circular(8),
    ),
    child: Icon(Icons.format_list_bulleted, color: Colors.brown),
    ),
    title: Text(
    "간략한 카드 이름",
    style: TextStyle(fontSize: 18, color: Colors.brown),
    ),
    tileColor: Colors.amber[100],
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    onTap: () {
    // 카드 클릭 동작
    print('Card $index clicked');
    },
    ),
    );
    },
    ),
 * */
