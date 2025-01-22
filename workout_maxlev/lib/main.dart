import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogoScreen(),
    );
  }
}

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    // 로딩이 끝난 후 로그인 화면으로 이동하는 코드
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 화면 배경색 검정
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/logo.png', // 로고 이미지 경로
                width: 150, // 로고 너비
                height: 150, // 로고 높이
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20), // 하단 여백
            child: Text(
              'Version_1.0',
              style: TextStyle(
                color: Colors.white, // 텍스트 색상 흰색
                fontSize: 16, // 텍스트 크기
                fontStyle: FontStyle.italic, // 기울임꼴
                fontWeight: FontWeight.bold, // 텍스트 굵게
              ),
            ),
          ),
        ],
      ),
    );
  }
}
