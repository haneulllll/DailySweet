import 'package:flutter/material.dart';
import 'homepage.dart';

/*
<<구현한 기능 목록>>
* LoginScreen: 사용자가 아이디와 비밀번호를 입력하여 로그인할 수 있는 화면
* 로그인 완료 후 메인 화면(CalendarPage)으로 이동
* CalendarPage: 로딩 화면 이후에 표시되는 메인 화면으로, 캘린더 형태로 일기를 관리
*/

class LoginScreen extends StatelessWidget {
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
                    onPressed: () {
                      // 로그인 완료 후 메인 화면으로 이동
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarPage()),
                      );
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
