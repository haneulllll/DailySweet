import 'package:flutter/material.dart';
import 'homepage.dart';
import 'callServer.dart';

/*
<<구현한 기능 목록>>
* LoginScreen: 사용자가 아이디와 비밀번호를 입력하여 로그인할 수 있는 화면
* 로그인 완료 후 메인 화면(CalendarPage)으로 이동
* CalendarPage: 로딩 화면 이후에 표시되는 메인 화면으로, 캘린더 형태로 일기를 관리
*/

import 'package:flutter/material.dart';
import 'homepage.dart';
import 'callServer.dart'; // ApiService 불러오기

class LoginScreen extends StatelessWidget {
  final ApiService apiService = ApiService(); // ApiService 인스턴스 생성

  // TextEditingController 추가
  final TextEditingController uidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2B2B2B),
      appBar: AppBar(
        backgroundColor: Color(0xFF2B2B2B),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 102,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // 이미지와 텍스트 간격
                  // 텍스트
                  Text(
                    'LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF4E1B7),
                      fontSize: 30,
                      fontFamily: 'Nanum SeongSirCe',
                      fontWeight: FontWeight.w400,
                      height: 1.5, // 줄 간격 조정
                    ),
                  ),
                  SizedBox(height: 70),
                  TextField(
                    controller: uidController, // uid 입력 컨트롤러 추가
                    decoration: InputDecoration(
                      hintText: '아이디',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontFamily: 'Nanum SeongSirCe',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: passwordController, // password 입력 컨트롤러 추가
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '비번',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontFamily: 'Nanum SeongSirCe',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () async {
                      // 로그인 버튼 클릭 시 서버와 통신하는 코드 추가
                      String uid = uidController.text.trim();
                      String password = passwordController.text.trim();

                      if (uid.isEmpty || password.isEmpty) {
                        // 사용자 입력값 검증
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('아이디와 비밀번호를 모두 입력하세요.')),
                        );
                        return;
                      }

                      try {
                        // 서버에 로그인 요청
                        String message = await apiService.login(uid, password);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );

                        // 로그인 성공 시 메인 화면으로 이동
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => CalendarPage()),
                        );
                      } catch (e) {
                        // 로그인 실패 시 에러 메시지 표시
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('로그인 실패: $e')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF4E1B7),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      '완  료',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nanum SeongSirCe',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
