import 'package:cs_onecup/features/auth/signinpage.dart';
import 'package:cs_onecup/features/auth/signuppage.dart';
import 'package:cs_onecup/core/constants/colors.dart';
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
              // 텍스트와 밑줄 이미지 배치
              Stack(
                children: [
                  // 텍스트 표시
                  Text(
                    '오늘, CS 한잔',
                    style: TextStyle(
                      color: AppColors.mainDeepOrange,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // 밑줄 이미지 위치 조정
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08, // 텍스트 아래로 약간 이동
                      left: MediaQuery.of(context).size.width * 0.2, // 텍스트 시작점 조정
                    ),
                    child: Image.asset(
                      'images/underline.png',
                      width: MediaQuery.of(context).size.width * 0.4, // 'CS 한잔' 길이에 맞춘 밑줄
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SigninPage()),
                  );
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
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
