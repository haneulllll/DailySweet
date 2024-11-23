import 'package:flutter/material.dart';
import 'splash.dart';
import 'login.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/*
<<구현한 기능 목록>>
* SplashScreen: 앱 실행 시 3초 동안 로딩 화면(splash.dart)을 보여준 후 홈 페이지(homepage.dart)로 이동
* CalendarPage: 로딩 화면 이후에 표시되는 메인 화면으로, 캘린더 형태로 일기를 관리
* initializeDateFormatting: 한국어 날짜 형식을 사용하기 위해 초기화합니다.
*/

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Diary App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 3초 후에 HomePage로 이동
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Splash(); // Splash 위젯을 사용하여 화면 구성
  }
}
