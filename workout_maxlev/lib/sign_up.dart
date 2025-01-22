import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isChecked = false; // 체크박스 상태
  String _nickname = ''; // 닉네임
  String _email = ''; // 이메일
  String _password = ''; // 비밀번호
  String _passwordConfirm = ''; // 비밀번호 확인

  // 입력값 검증 로직
  void _validateAndSubmit() {
    if (_nickname.isEmpty ||
        _email.isEmpty ||
        _password.isEmpty ||
        _passwordConfirm.isEmpty) {
      _showAlertDialog('필수 입력사항을 확인해주세요.');
    } else if (_password != _passwordConfirm) {
      _showAlertDialog('비밀번호가 일치하지 않습니다.');
    } else if (!_isChecked) {
      _showAlertDialog('개인정보 처리방침 및 이용약관에 동의해주세요.');
    } else {
      // 가입 완료 처리
      print('가입 완료');
    }
  }

  // 경고 메시지 표시
  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

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
            _buildTextField('닉네임', (value) {
              _nickname = value;
            }),
            SizedBox(height: 10),
            // 이메일 입력
            _buildTextField('이메일', (value) {
              _email = value;
            }),
            SizedBox(height: 10),
            // 비밀번호 입력
            _buildTextField('비밀번호', (value) {
              _password = value;
            }, obscureText: true),
            SizedBox(height: 10),
            // 비밀번호 확인
            _buildTextField('비밀번호 확인', (value) {
              _passwordConfirm = value;
            }, obscureText: true),
            SizedBox(height: 20),
            // 개인정보 동의
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
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
                onPressed: _validateAndSubmit,
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
                    Navigator.pop(context);
                  },
                  child: Text(
                    '로그인창으로 돌아가기',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('비밀번호 찾기');
                  },
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

  Widget _buildTextField(String label, Function(String) onChanged,
      {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      onChanged: onChanged,
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
