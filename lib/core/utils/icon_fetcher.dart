


import 'package:flutter/widgets.dart';

class IconFetcher {
  static Image fetchImage(String category, double? width, double? height) {
    String imagePath = fetchPath(category);
    return Image.asset(
      'assets/icons/icon_questionQ.png',
      width: width ?? 100,
      height: height ?? 100,
    );
  }

  static String fetchPath(String category) {
    String imagePath;
    switch (category) {
      case '운영체제':
        imagePath = 'assets/icons/icon_category_OS.png';
        break;
      case '네트워크':
        imagePath = 'assets/icons/icon_category_network.png';
        break;
      case '데이터베이스':
        imagePath = 'assets/icons/icon_category_DB.png';
        break;
      case '자료구조':
        imagePath = 'assets/icons/icon_category_dataStructure.png';
        break;
      case '소프트웨어공학':
        imagePath = 'assets/icons/icon_category_SE.png';
        break;
      case '프로그래밍':
        imagePath = 'assets/icons/icon_category_programming.png';
        break;
      default:
        imagePath = 'assets/icons/icon_none.png';
    }
    return imagePath;
  }
}