import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../core/constants/config.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _isPasswordVisible = false; // Toggle password visibility
  final TextEditingController _idController =
      TextEditingController(); // ID 입력 필드
  final TextEditingController _passwordController =
      TextEditingController(); // 비밀번호 입력 필드

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainLightGray, // Background color
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainLightGray,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0XFF3F414E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Coffee icon
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/coffee_cat.png',
                      width: MediaQuery.of(context).size.width *
                          0.4, // 'CS 한잔' 길이에 맞춘 밑줄
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "CS 한잔",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: AppColors.mainLightOrange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "로그인",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainDeepOrange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ID Field
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: "아이디",
                  filled: true,
                  fillColor: AppColors.mainBeige,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible, // Toggle visibility
                decoration: InputDecoration(
                  labelText: "비밀번호",
                  filled: true,
                  fillColor: AppColors.mainBeige,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.mainDeepOrange,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Login Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainDeepOrange, // Button color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: _login,
                child: const Text(
                  "로그인",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 로그인 함수
  Future<void> _login() async {
    const url = '${Config.baseUrl}/api/user/signin';

    final String userId = _idController.text.trim();
    final String password = _passwordController.text.trim();

    if (userId.isEmpty || password.isEmpty) {
      _showErrorDialog("아이디와 비밀번호를 입력해주세요.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['data']['response'];

        // 토큰을 SharedPreferences에 저장
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        // 로그인 성공 메시지
        Navigator.pushNamed(context, '/home');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomePage()),
        // );
      } else {
        _showErrorDialog("로그인 실패: ${response.body}");
      }
    } catch (e) {
      _showErrorDialog("오류가 발생했습니다: $e");
    }
  }

  // 에러 다이얼로그
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("에러"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("확인"),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }
}
