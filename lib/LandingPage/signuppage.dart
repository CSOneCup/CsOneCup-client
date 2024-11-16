import 'package:cs_onecup/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cs_onecup/config.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? idErrorText;
  String? passwordErrorText;
  String? nameErrorText;

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainLightGray,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0XFF3F414E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.mainLightGray,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset(
                'images/coffee_cat.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                'CS 한잔',
                style: TextStyle(
                  color: AppColors.mainLightOrange,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '회원가입',
                style: TextStyle(
                  color: AppColors.mainDeepOrange,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(
                label: '아이디',
                controller: _idController,
                errorText: idErrorText,
              ),
              _buildTextField(
                label: '이름',
                controller: _nameController,
                errorText: nameErrorText,
              ),
              _buildTextField(
                label: '비밀번호',
                controller: _passwordController,
                obscureText: true,
              ),
              _buildTextField(
                label: '비밀번호 중복 확인',
                controller: _confirmPasswordController,
                obscureText: true,
                errorText: passwordErrorText,
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
                onPressed: _validateForm,
                child: Text(
                  '시작하기',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    String? errorText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.mainBeige,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _validateForm() async {
    setState(() {
      if(_idController.text.isEmpty) {
        idErrorText = '아이디를 입력해주세요';
      }
      else if (_idController.text == 'isExist') {
        idErrorText = '이미 존재하는 아이디입니다';
      }
      else {
        idErrorText = null;
      }

      // 비밀번호 확인 로직
      if(_passwordController.text.isEmpty) {
        passwordErrorText = '비밀번호를 입력해 주세요';
      }
      else if (_passwordController.text != _confirmPasswordController.text) {
        passwordErrorText = '비밀번호가 동일하지 않습니다';
      }
      else {
        passwordErrorText = null;
      }

      if(_nameController.text.isEmpty) {
        nameErrorText = '이름을 입력해 주세요';
      }
      else {
        nameErrorText = null;
      }
    });

    if (idErrorText == null && passwordErrorText == null) {
      await _signUp();
    }
  }

  Future<void> _signUp() async {
    const url = '${Config.baseUrl}/api/user/signup';

    try {
      // 요청 데이터
      final requestBody = {
        'user_id': _idController.text,
        'name': _nameController.text,
        'password': _passwordController.text,
      };

      // POST 요청
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // 성공
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('회원가입 성공! 🎉'),
            duration: Duration(seconds: 5),
            backgroundColor: AppColors.mainLightOrange,
          ),
        );
        Navigator.pop(context);
      }
      else {
        setState(() {
          idErrorText = '이미 존재하는 아이디입니다';
        });
        final responseBody = jsonDecode(response.body);
      }
    }
    catch (e) {
      // 에러 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('네트워크 오류가 발생했습니다: $e'),
          duration: Duration(seconds: 20),
          backgroundColor: AppColors.mainDeepOrange,
        ),
      );
    }
  }
}
