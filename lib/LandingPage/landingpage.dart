import 'package:cs_onecup/colors.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 화면 너비를 계산하여 버튼 너비의 비율로 활용합니다.
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              AppColors.mainBeige,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                '매일 한잔씩 마시는 CS 지식',
                style: TextStyle(
                  color: AppColors.mainLightOrange,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '오늘, ',
                          style: TextStyle(
                            color: AppColors.mainDeepOrange,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'CS 한잔',
                          style: TextStyle(
                            color: AppColors.mainDeepOrange,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, left: 90),
                    child: Image.asset(
                      'images/underline.png', // 밑줄 이미지 경로를 업데이트하세요.
                      width: 120, // 'CS 한잔' 텍스트 길이에 맞춰 이미지 크기 조정
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Image.asset(
                'images/coffee_cat.png', // 이미지 경로를 확인하세요.
                width: 200,
                height: 200,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainDeepOrange,
                  minimumSize: Size(buttonWidth, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Add login functionality here
                },
                child: Text(
                  '로그인',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainDeepOrange,
                  minimumSize: Size(buttonWidth, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Add sign-up functionality here
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
