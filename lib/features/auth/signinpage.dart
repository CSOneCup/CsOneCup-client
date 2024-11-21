import 'package:cs_onecup/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _isPasswordVisible = false; // Toggle password visibility

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
      body: Padding(
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
                  SizedBox(height: 8),
                  Text(
                    "CS 한잔",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.mainLightOrange,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
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
            SizedBox(height: 32),

            // ID Field
            TextFormField(
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
            SizedBox(height: 16),

            // Password Field
            TextFormField(
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
            SizedBox(height: 32),

            // Login Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainDeepOrange, // Button color
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () {
                // Add button action here
              },
              child: Text(
                "로그인",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
