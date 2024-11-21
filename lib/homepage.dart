import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Typing.dart';
import 'month_feedback.dart';

/*
<<구현한 기능 목록>>
* CalendarPage: 캘린더 형태로 일기를 관리할 수 있는 페이지를 생성
* _previousMonth: 이전 달로 이동하는 함수
* _nextMonth: 다음 달로 이동하는 함수
* _getDiaryCountForCurrentMonth: 현재 월에 작성된 일기 수를 반환하는 함수
* _buildWeekdayHeader: 요일 헤더를 생성하는 위젯
* _buildCalendar: 달력의 각 날짜를 생성하는 위젯
* _buildBottomNavigation: 하단 네비게이션 바를 생성하는 위젯
* _showPotatoPopup: 일기 작성 횟수가 5회 미만일 경우 팝업창을 표시하는 함수
*/

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();
  Map<DateTime, String> diaryEntries = {}; // 일기 내용을 저장하는 Map

  // 이전 달로 이동하는 함수
  void _previousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
    });
  }

  // 다음 달로 이동하는 함수
  void _nextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    });
  }

  // 현재 월의 일기 작성 횟수를 반환하는 함수
  int _getDiaryCountForCurrentMonth() {
    return diaryEntries.keys.where((date) =>
    date.year == _currentDate.year && date.month == _currentDate.month).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          // 월 표시 및 이전/다음 버튼
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: _previousMonth,
                ),
                Text(
                  DateFormat('yyyy. M').format(_currentDate),
                  style: TextStyle(color: Colors.white, fontFamily: 'Nanum SeongSirCe', fontSize: 25),
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: _nextMonth,
                ),
              ],
            ),
          ),
          Divider(color: Colors.white54),
          _buildWeekdayHeader(), // 요일 헤더 생성
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildCalendar(), // 달력 생성
            ),
          ),
          _buildBottomNavigation(), // 하단 네비게이션 생성
        ],
      ),
    );
  }

  // 요일 헤더를 생성하는 위젯
  Widget _buildWeekdayHeader() {
    const List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays
          .map((day) => Expanded(
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Nanum SeongSirCe',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ))
          .toList(),
    );
  }

  // 달력의 각 날짜를 생성하는 위젯
  Widget _buildCalendar() {
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final lastDayOfMonth = DateTime(_currentDate.year, _currentDate.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final startingWeekday = firstDayOfMonth.weekday;

    List<Widget> dayWidgets = [];
    dayWidgets.addAll(List.generate(startingWeekday - 1, (_) => SizedBox()));

    for (int day = 1; day <= daysInMonth; day++) {
      final currentDay = DateTime(_currentDate.year, _currentDate.month, day);
      final isToday = DateTime.now().year == currentDay.year &&
          DateTime.now().month == currentDay.month &&
          DateTime.now().day == currentDay.day;
      final hasDiaryEntry = diaryEntries.containsKey(currentDay);
      final isFutureDate = currentDay.isAfter(DateTime.now());

      dayWidgets.add(
        GestureDetector(
          onTap: isFutureDate
              ? null
              : () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TypingPage(date: currentDay, diaryEntries: diaryEntries),
              ),
            );
            if (result != null) {
              setState(() {
                diaryEntries[currentDay] = result;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isToday ? Color(0xFFF4E1B7) : Colors.transparent,
              border: hasDiaryEntry && !isToday ? Border.all(color: Color(0xFFF4E1B7)) : null,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  color: isToday ? Colors.black : (isFutureDate ? Colors.grey : Colors.white),
                  fontFamily: 'Nanum SeongSirCe',
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      children: dayWidgets,
    );
  }

  // 하단 네비게이션 바 생성
  Widget _buildBottomNavigation() {
    return SafeArea(
      child: BottomAppBar(
        color: Colors.grey.shade500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/calendar.png',
                  width: 23,
                  height: 23,
                ),
                Text(
                  '달력',
                  style: TextStyle(
                    color: Color(0xFFF5F5F5),
                    fontSize: 14,
                    fontFamily: 'Nanum SeongSirCe',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
            FloatingActionButton(
              backgroundColor: Color(0xFFF4E1B7),
              child: Icon(Icons.add),
              onPressed: () {
                final today = DateTime.now();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TypingPage(date: today, diaryEntries: diaryEntries)),
                );
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Image.asset(
                      'images/potato.png',
                      width: 25,
                      height: 25,
                    ),
                    onPressed: () {
                      int diaryCount = _getDiaryCountForCurrentMonth();
                      if (diaryCount >= 5) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MonthFeedbackPage()),
                        );
                      } else {
                        _showPotatoPopup(context);
                      }
                    },
                  ),
                ),
                Text(
                  '내 고구마',
                  style: TextStyle(
                    color: Color(0xFFF5F5F5),
                    fontSize: 15,
                    fontFamily: 'Nanum SeongSirCe',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 팝업 창을 표시하는 함수
  void _showPotatoPopup(BuildContext context) {
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
                width: 60,
                height: 60,
              ),
              SizedBox(height: 10),
              Text(
                '내 고구마를 생성하려면 일기를 5번 이상 써야해요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nanum SeongSirCe',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF4E1B7),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '알겠습니다!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Nanum SeongSirCe',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
