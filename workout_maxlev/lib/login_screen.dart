import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_maxlev/sign_up.dart'; // sign_up.dart 파일을 임포트
import 'package:workout_maxlev/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 이미 가입된 이메일로 로그인 처리
  Future<void> signInWithEmailPassword() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      // Firebase로 이메일과 비밀번호 로그인 처리
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print('로그인 성공: ${userCredential.user?.email}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 성공: ${userCredential.user?.email}')),
      );

      // 로그인 후 MainScreen으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } catch (e) {
      print('이메일/패스워드 로그인 실패: $e');
      String errorMessage = "로그인 실패";

      // FirebaseAuthException 처리
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = '해당 이메일로 가입된 계정이 없습니다.';
        } else if (e.code == 'wrong-password') {
          errorMessage = '비밀번호가 잘못되었습니다.';
        } else {
          errorMessage = e.message ?? '로그인 오류 발생';
        }
      }

      // 로그인 실패 시 알림 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  // 구글 로그인 처리 함수
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth != null &&
        googleAuth.accessToken != null &&
        googleAuth.idToken != null) {
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      throw FirebaseAuthException(
        message: "구글 로그인 실패",
        code: "ERROR_GOOGLE_SIGN_IN_FAILED",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 40),
            // 이메일 입력 필드
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '이메일',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            // 비밀번호 입력 필드
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            // 로그인 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: signInWithEmailPassword, // 이메일로 로그인
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  '로그인',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            // 이메일로 가입하기 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 이메일로 가입하기 버튼 클릭 시 SignUpScreen으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  '이메일로 가입하기',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            // 구글 계정으로 시작하기 버튼
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await signInWithGoogle();
                    print('로그인 성공: ${userCredential.user?.displayName}');
                    // 로그인 성공 후 MainScreen으로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  } catch (e) {
                    print('구글 로그인 실패: $e');
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/google.png',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 10),
                    Text('구글 계정으로 시작하기', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
