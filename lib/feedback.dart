import 'package:flutter/material.dart';
import 'homepage.dart';

class FeedbackPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isWarm;

  FeedbackPage({
    required this.title,
    required this.imagePath,
    required this.isWarm,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text("selection"),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 돌아가기
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 선택한 고구마 스타일 제목 표시
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nanum SeongSirCe',
                  ),
                  children: [
                    TextSpan(text: "〈 "),
                    TextSpan(
                      text: title,
                      style: TextStyle(color: Color(0xFFF4E1B7)),
                    ),
                    TextSpan(text: "의 충고 〉"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // 충고 내용을 표시하는 컨테이너
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 선택한 스타일의 이미지 표시
                  Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        // 첫 번째 충고 텍스트 컨테이너
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Nanum SeongSirCe',
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        // 두 번째 충고 텍스트 컨테이너
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
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
            SizedBox(height: 20),
            // 추천 섹션 제목
            Center(
              child: Text(
                "〈 그 외 추천해드려요 〉",
                style: TextStyle(
                  color: Color(0xFFF4E1B7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nanum SeongSirCe',
                ),
              ),
            ),
            SizedBox(height: 20),
            // 추천 항목 표시
            _buildRecommendationBox("감정 추천"),
            SizedBox(height: 16),
            _buildRecommendationBox("책 추천"),
            SizedBox(height: 16),
            _buildRecommendationBox("논문 추천"),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  // 다른 스타일 고구마 버튼
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // 다른 스타일의 FeedbackPage로 이동
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackPage(
                            title: isWarm ? "냉철한 고구마" : "따뜻한 고구마",
                            imagePath: isWarm ? 'images/4.png' : 'images/2.png',
                            isWarm: !isWarm, // 반대 스타일로 이동
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "다른 스타일 고구마",
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nanum SeongSirCe', fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  // 완료 버튼
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF4E1B7),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // CalendarPage로 이동하고 이전 페이지 스택 제거
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarPage()),
                            (route) => false,
                      );
                    },
                    child: Text(
                      "완료",
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nanum SeongSirCe', fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 추천 상자를 생성하는 메서드
  Widget _buildRecommendationBox(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 추천 항목 제목
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nanum SeongSirCe',
            ),
          ),
          SizedBox(height: 8),
          // 추천 항목 내용 텍스트 컨테이너 1
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Nanum SeongSirCe',
              ),
            ),
          ),
          SizedBox(height: 8),
          // 추천 항목 내용 텍스트 컨테이너 2
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Nanum SeongSirCe',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 임의의 HomePage 클래스 정의 (메인 페이지)
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text("메인 페이지입니다."),
      ),
    );
  }
}
