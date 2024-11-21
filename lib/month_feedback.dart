import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'collection.dart';

/*
<<구현한 기능 목록>>
* MonthFeedbackPage: 현재 월의 일기내용을 분석한 결과, 생성된 고구마를 표시하는 페이지
* AppBar: 화면 상단에 제목, 뒤로가기 버튼, 고구마 컬렉션 버튼을 통해 고구마 컬렉션 페이지로 이동
*/

class MonthFeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String month = DateFormat.MMM('ko_KR').format(DateTime.now()); // 현재 월 정보 가져오기

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
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40, // Column 내에서 고정된 크기를 지정
                child: IconButton(
                  padding: EdgeInsets.zero, // 아이콘 버튼의 기본 패딩 제거
                  icon: Image.asset(
                    'images/potato.png',
                    width: 25,
                    height: 25,
                  ), // 고구마 컬렉션 아이콘
                  tooltip: "고구마 컬렉션",
                  onPressed: () {
                    // 고구마 컬렉션 클릭 시 CollectionPage로 전환
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CollectionPage()),
                    );
                  },
                ),
              ),
              SizedBox(height: 4), // 아이콘과 텍스트 사이 간격 조정
              Text(
                '고구마 컬렉션',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Nanum SeongSirCe',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // 월별 고구마 스타일 제목 표시
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
                    TextSpan(text: "$month의 나는 이런 "),
                    TextSpan(
                      text: "고구마",
                      style: TextStyle(color: Color(0xFFF4E1B7)),
                    ),
                    TextSpan(text: "예요 !"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // 월별 고구마 이미지 및 설명을 담은 컨테이너
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // 고구마 이미지 표시
                  Image.asset(
                    'images/3.png', // 월에 맞는 고구마 이미지 첨부
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 12),
                  // 고구마 스타일 제목 표시
                  Text(
                    "“나는 [ 안경잡이 고구마 ] 예요”",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nanum SeongSirCe',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // 고구마 스타일 설명 텍스트
            Text(
              "힘든 상황에서도 포기하지 않고, 다양한 솔루션을 얻으며 문제를 해결해내는 능력을 가진 고구마예요. 고민이 많더라도 항상 더 나은 답을 찾기 위해 노력하며 성장하고, 주변에도 긍정적인 에너지를 주는 고구마라고 할 수 있죠.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Nanum SeongSirCe',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
