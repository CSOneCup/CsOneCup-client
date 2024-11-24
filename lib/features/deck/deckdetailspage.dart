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
      backgroundColor: AppColors.mainBeige,
      appBar: AppBar(
        backgroundColor: AppColors.mainBeige,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.brown),
          onPressed: () {
            // 뒤로가기 버튼 동작
            Navigator.pop(context);
          }
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 편집 버튼 동작
            },
            child: const Text(
              "편집",
              style: TextStyle(
                fontSize: 20,
                color: Colors.brown
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // 공유 버튼 동작
            },
            child: const Text(
              "공유",
              style: TextStyle(
                fontSize: 20,
                color: Colors.brown
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // 덱 제목 & 카드 수
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: const [
                Text(
                  "나의 덱 이름",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.normal,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "18 cards",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          // 카드 리스트
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: ListTile(
          // 아이콘
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.format_list_bulleted, color: Colors.brown),
          ),
          // 제목
          title: Center(
            child: const Text(
              "간략한 카드 이름",
              style: TextStyle(
                fontSize: 18,
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onTap: () {
            // 카드 클릭 이벤트
          },
        ),
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
