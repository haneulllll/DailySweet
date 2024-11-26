import 'dart:io';
import 'package:flutter/material.dart';
import 'selectTorF.dart';
import 'EntryHandler.dart';

/*
<<구현한 기능 목록>>
* TypingPage: 사용자가 일기를 작성할 수 있는 페이지
* TextField: 사용자가 일기를 입력할 수 있는 입력 필드를 제공
* AppBar: 화면 상단에 뒤로가기 버튼과 페이지 제목을 표시
* 완료 버튼: 작성한 일기를 저장하고, 분석 여부를 묻는 팝업 창을 띄움
* _showAnalysisDialog: 일기 분석 여부를 묻는 팝업 창을 표시하는 함수
* Navigator: 사용자가 선택한 옵션에 따라 일기 분석 페이지(SelectTorFPage)로 이동하거나, 일기만 기록하고 돌아옴
*/


class TypingPage extends StatelessWidget {
  late EntryHandler entryHandler;
  final DateTime date;
  Map<DateTime, String> diaryEntries = {};
  final TextEditingController textController;
  Future<void> ent() async{
    entryHandler = await EntryHandler.create();
    diaryEntries = entryHandler.loadEntrySync(); // 데이터를 로드하여 diaryEntries에 저장
  }

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
                onPressed: () async{
                  await ent();
                  diaryEntries[date] = textController.text; // 일기 내용을 미리 저장
                  entryHandler.addEntrySync(date, textController.text);
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
                        onPressed: () async{
                          await ent();
                          diaryEntries[date] = textController.text; // 일기 내용 저장
                          entryHandler.addEntrySync(date, textController.text);
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
