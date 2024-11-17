import 'package:diary_ui/feedback.dart';
import 'package:flutter/material.dart';

class SelectTorFPage extends StatelessWidget {
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
            // 타이틀 텍스트 설정
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nanum SeongSirCe',
                  ),
                  children: [
                    TextSpan(text: "원하는 "),
                    TextSpan(
                      text: "고구마",
                      style: TextStyle(color: Color(0xFFF4E1B7)),
                    ),
                    TextSpan(text: " \n스타일을 골라주세요!"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // 따뜻한 고구마 버튼
            _buildPotatoButton(
              context,
              imagePath: 'images/2.png',
              title: "따뜻한 고구마",
              isWarm: true,
              description: "일기 내용을 분석한 뒤, 따뜻한 치유의 말을 해줍니다.\n감정적인 치유가 필요한 분들에게 추천합니다.",
            ),
            SizedBox(height: 20),
            // 냉철한 고구마 버튼
            _buildPotatoButton(
              context,
              imagePath: 'images/4.png',//하드코딩, 수정 요함
              title: "냉철한 고구마",
              isWarm: false,
              description: "일기 내용을 분석한 뒤, 최적화된 솔루션을 제공합니다.\n해결책이 필요한 분들에게 추천합니다.",
            ),
          ],
        ),
      ),
    );
  }

  // 고구마 스타일 선택 버튼을 구성하는 메서드
  Widget _buildPotatoButton(
      BuildContext context, {
        required String imagePath,
        required String title,
        required String description,
        required bool isWarm,
      }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // 버튼 배경색을 흰색으로 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // 버튼 모서리 둥글게 설정
        ),
        padding: EdgeInsets.all(16),
      ),
      onPressed: () {
        // FeedbackPage로 이동, 선택한 스타일에 따라 페이지 설정
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeedbackPage(
              title: title,
              imagePath: imagePath,
              isWarm: isWarm,
            ),
          ),
        );
      },
      child: Column(
        children: [
          // 고구마 이미지
          Image.asset(
            imagePath,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8),
          // 고구마 스타일 제목 텍스트
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nanum SeongSirCe',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          // 고구마 스타일 설명 텍스트
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontFamily: 'Nanum SeongSirCe',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
