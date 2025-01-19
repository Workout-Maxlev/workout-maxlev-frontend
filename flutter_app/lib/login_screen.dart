import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  // 구글 로그인 처리 함수
  Future<UserCredential> signInWithGoogle() async {
    // 구글 로그인 객체 생성
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // 로그인 플로우 시작
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // 인증 정보 가져오기
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // 인증이 성공적으로 이루어졌다면 Firebase 인증 처리
    if (googleAuth != null &&
        googleAuth.accessToken != null &&
        googleAuth.idToken != null) {
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase로 로그인 처리
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      throw FirebaseAuthException(
          message: "구글 로그인 실패", code: "ERROR_GOOGLE_SIGN_IN_FAILED");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 화면 배경색 검정
      body: Padding(
        padding: const EdgeInsets.all(20.0), // 모든 가장자리에 여백 추가
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 수평 중앙 정렬
          children: [
            // 로고 이미지
            Image.asset(
              'assets/logo.png', // 로고 이미지 경로 (assets 폴더에 넣은 logo.png 파일)
              width: 150, // 로고 너비
              height: 150, // 로고 높이
            ),
            SizedBox(height: 40), // 로고와 입력 필드 사이 여백

            // 구글 계정으로 시작하기 버튼
            OutlinedButton(
              onPressed: () async {
                try {
                  // 구글 로그인 처리
                  UserCredential userCredential = await signInWithGoogle();
                  print('로그인 성공: ${userCredential.user?.displayName}');
                  // 로그인 성공 시 처리 로직
                } catch (e) {
                  print('구글 로그인 실패: $e');
                  // 오류 처리 로직
                }
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // 텍스트와 아이콘을 왼쪽 정렬
                children: [
                  // 구글 이미지 추가 (왼쪽에 배치)
                  Image.asset(
                    'assets/google.png', // google.png 이미지 경로
                    width: 20, // 이미지 크기 조정 (작게)
                    height: 20,
                  ),
                  SizedBox(width: 10), // 이미지와 텍스트 사이 여백
                  Text('구글 계정으로 시작하기', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
