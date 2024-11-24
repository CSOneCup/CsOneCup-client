import "package:cs_onecup/core/constants/colors.dart";
import "package:cs_onecup/core/widgets/simplecardwidget.dart";
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
      body: Column(
        children: [
          // 덱 제목 여기에

          Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) => SimpleCardTile(index: index)
              )
          )
        ],
      )
    );
  }
}

class SimpleCardTile extends StatelessWidget {
  final int index;
  const SimpleCardTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue, // 배경색
              borderRadius: BorderRadius.circular(12), // 둥근 테두리
              border: Border.all(color: Colors.black, width: 3), // 테두리
            ),
            padding: EdgeInsets.all(5),
            child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.mainBeige,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.format_list_bulleted, color: Colors.brown),
                ),
                title: const Center(
                  child: Text(
                    "카드 이름",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                    textAlign: TextAlign.center, // 텍스트 가운데 정렬
                  ),
                ),
                tileColor: AppColors.cardBeige,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  // 카드 클릭
                  print("Card $index clicked");
                }
            ),
          ),

        ],
      )


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
