import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';

class QuizCardwidget extends StatelessWidget {
  final double scaleFactor;
  String quizCategory = '운영체제';
  late String _quizImage;
  String quizExplanation = '운영체제가 제공하는 기능에 해당하지 않는 것은 무엇인가요?';

  QuizCardwidget({
    super.key,
    this.scaleFactor = 1.0,
    required this.quizCategory,
    required this.quizExplanation,
  });

  // final String _quizExplanationLong =
  //     'A 레코드는 도메인 이름을 특정 IP 주소로 매핑하는 데 사용되어 웹 서버의 실제 위치를 가리킵니다. CNAME 레코드는 도메인 간의 별칭을 생성하지만 SSL/TLS 설정에 필수적이지 않으며, TXT 레코드는 SPF와 DKIM 설정을 통해 이메일 인증을 지원합니다. 이로 인해 SSL/TLS와 이메일 인증 모두에 세 레코드가 필수적이라는 설명은 틀립니다.';

  @override
  Widget build(BuildContext context) {
    switch (quizCategory) {
      case '운영체제':
        _quizImage = 'assets/icons/icon_category_OS.png';
        break;
      case '네트워크':
        _quizImage = 'assets/icons/icon_category_network.png';
        break;
      case '데이터베이스':
        _quizImage = 'assets/icons/icon_category_DB.png';
        break;
      case '자료구조':
        _quizImage = 'assets/icons/icon_category_dataStructure.png';
        break;
      case '소프트웨어공학':
        _quizImage = 'assets/icons/icon_category_SE.png';
        break;
      case '프로그래밍':
        _quizImage = 'assets/icons/icon_category_programming.png';
        break;
      default:
        _quizImage = 'assets/icons/icon_none.png';
    }

    return Stack(children: [
      SizedBox(
          width: 170 * scaleFactor,
          height: 285 * scaleFactor,
          child: Card(
            color: const Color(0xFFF4F4F4),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(15)),
            ),
          )),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (11 * scaleFactor), vertical: (11 * scaleFactor)),
        child: SizedBox(
          width: 148 * scaleFactor,
          height: 263 * scaleFactor,
          child: Card(
            color: AppColors.cardBeige,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          quizCategory,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image.asset(_quizImage, width: 40, height: 40),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/icons/icon_questionQ.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: Text(
                      quizExplanation,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
