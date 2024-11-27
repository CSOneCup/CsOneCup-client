import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';

class AnswerCardwidget extends StatelessWidget {
  final double scaleFactor;
  String quizAnswer;
  String answerExplanation;

  AnswerCardwidget({
    super.key,
    this.scaleFactor = 1.0,
    required this.quizAnswer,
    required this.answerExplanation,
  });

  // final String _quizExplanationLong =
  //     'A 레코드는 도메인 이름을 특정 IP 주소로 매핑하는 데 사용되어 웹 서버의 실제 위치를 가리킵니다. CNAME 레코드는 도메인 간의 별칭을 생성하지만 SSL/TLS 설정에 필수적이지 않으며, TXT 레코드는 SPF와 DKIM 설정을 통해 이메일 인증을 지원합니다. 이로 인해 SSL/TLS와 이메일 인증 모두에 세 레코드가 필수적이라는 설명은 틀립니다.';

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/icons/icon_answerA.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    quizAnswer,
                    style: const TextStyle(
                      color: AppColors.mainDeepOrange,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        answerExplanation,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
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
