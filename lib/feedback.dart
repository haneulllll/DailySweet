import 'package:flutter/material.dart';
import 'homepage.dart';

/*
<<구현한 기능 목록>>
* FeedbackPage: 선택한 고구마 스타일에 대한 피드백을 표시하는 페이지
* AppBar: 페이지 상단의 제목 및 뒤로가기 버튼을 표시
* RichText: 선택한 고구마 스타일의 제목을 강조하여 표시합니다.
* _buildRecommendationBox: 조언,음악, 책, 논문의 추천 항목을 표시하는 위젯
* Navigator: 페이지 간 이동을 처리 (이전 화면으로 돌아가기, 다른 스타일로 이동, 완료 버튼을 눌러 메인 페이지로 이동)
*/

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
                            isWarm
                                ? "네가 힘들 때는 언제든지 기대도 돼. 네가 힘들어하는 것을 표현하는 것은 약한 게 아니라 용기 있는 행동이야. 너의 마음을 나누면 더 가벼워질 거야."
                                : "언제나 사람을 많이 배려하는 것은 좋지만, 때로는 네 자신의 경계도 지켜야 해. 상대방을 너무 의식하다 보면 너 자신이 지치거나 힘들어질 수 있어.",
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
                            isWarm
                                ? "너는 정말 소중한 사람이야. 네가 느끼는 감정은 모두 가치가 있어. 솔직하게 표현해도 괜찮아. 우리가 함께 할 때, 모든 걱정은 조금씩 줄어들 거야."
                                : "때로는 솔직한 의견을 말하는 것도 중요한 용기야. 네가 진심을 담아 표현할 때, 상대방도 너의 진심을 이해할 수 있어.",
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
              title == "감정 추천"
                  ? "1.아이유 - 무릎:\n편안하고 따뜻한 멜로디가 마음을 진정시켜 줄 거야."
                  : title == "책 추천"
                  ? "<<사람을 얻는 기술>> - 지시니 지음 \n상대방과의 관계에서 너의 감정을 지키며 건강하게 소통하는 방법에 대해 알려 줄 거야."
                  : "1.Boundary Setting in Friendships : \n친구 관계에서 경계를 설정하고 조정하는 법에 대한 연구 자료야. 친구와의 관계 속에서 네 자신을 지킬 수 있는 방법을 알려 줄 거야.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
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
              title == "감정 추천"
                  ? "2.볼빨간사춘기 - 우주를 줄게: \n따뜻한 감성의 노래로 위로를 받아보자."
                  : title == "책 추천"
                  ? "<<화성에서 온 남자 금성에서 온 여자>> - 존 그레이 \n남녀의 차이를 이해하고 관계를 개선할 수 있는 방법을 담고 있어."
                  : "2.Emotional Expression and Conflict in Friendships : \n친구 간의 갈등과 감정 표현에 대한 연구야. 네가 현재 느끼고 있는 감정에 대해 이해하는 데 도움이 될 거야.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
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
