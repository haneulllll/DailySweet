import 'package:flutter/material.dart';
import 'selectTorF.dart';

class TypingPage extends StatelessWidget {
  final DateTime date;
  final Map<DateTime, String> diaryEntries; // 일기 내용을 저장하는 Map 추가
  final TextEditingController textController;

  TypingPage({required this.date, required this.diaryEntries})
      : textController = TextEditingController(text: diaryEntries[date] ?? ''); // 생성자에서 초기화

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Typing',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 프로필 이미지 및 타이틀
            Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('images/1.png'),
                  backgroundColor: Colors.transparent,
                ),
                Text(
                  'TITLE',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nanum SeongSirCe',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.white54, thickness: 1),
              ],
            ),
            SizedBox(height: 20),
            // 일기 작성 입력 필드
            Expanded(
              child: TextField(
                controller: textController, // TextField에 Controller 연결
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nanum SeongSirCe',
                  fontSize: 18,
                ),
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  hintText: "Write your diary here...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            // 완료 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  diaryEntries[date] = textController.text; // 일기 내용을 미리 저장
                  _showAnalysisDialog(context); // 팝업창 띄우기
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF4E1B7),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '완료',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Nanum SeongSirCe',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 팝업 창을 표시하는 함수
  void _showAnalysisDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/1.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                '고구마가 일기 분석을 해드릴까요?',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Nanum SeongSirCe',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SelectTorFPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF4E1B7),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '네, 분석할래요.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Nanum SeongSirCe'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context, textController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF4E1B7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '아니요, 기록만 할래요.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Nanum SeongSirCe'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
