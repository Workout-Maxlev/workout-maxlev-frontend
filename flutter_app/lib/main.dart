import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogoScreen(),
    );
  }
}

class LogoScreen extends StatelessWidget {
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
