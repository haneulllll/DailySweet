import 'package:flutter/material.dart';

/*
<<구현한 기능 목록>>
* Splash: 앱 실행 시 처음 보여지는 로딩 화면을 구성하는 위젯
* 중앙에 로고 이미지와 앱 이름을 텍스트로 표시
*/

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF353535),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이미지
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
              'DAILY\nSWEET',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF4E1B7),
                fontSize: 30,
                fontFamily: 'Nanum SeongSirCe',
                fontWeight: FontWeight.w400,
                height: 1.5, // 줄 간격 조정
              ),
            ),
          ],
        ),
      ),
    );
  }
}
