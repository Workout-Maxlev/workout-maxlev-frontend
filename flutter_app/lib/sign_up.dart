import 'package:flutter/material.dart';
import 'package:flutter_app/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50), // 상단 여백
            Text(
              '회원가입',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            // 닉네임 입력
            _buildTextField('닉네임'),
            SizedBox(height: 10),
            // 이메일 입력
            _buildTextField('이메일'),
            SizedBox(height: 10),
            // 비밀번호 입력
            _buildTextField('비밀번호', obscureText: true),
            SizedBox(height: 10),
            // 비밀번호 확인
            _buildTextField('비밀번호 확인', obscureText: true),
            SizedBox(height: 20),
            // 개인정보 동의
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                  activeColor: Colors.white,
                  checkColor: Colors.blue,
                ),
                Expanded(
                  child: Text(
                    '개인정보 처리방침 및 이용약관에 동의합니다.',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // 가입 완료 버튼
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '가입 완료',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Spacer(),
            // 하단 텍스트 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    '로그인으로 돌아가기',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '비밀번호를 잃어버렸어요',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
