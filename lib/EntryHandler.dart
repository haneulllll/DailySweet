import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class EntryHandler {
  final String filePath;
  Map<DateTime, String> _cachedData;

  // 일반 생성자: 외부에서 filePath를 전달받음
  EntryHandler._(this.filePath) : _cachedData = {};

  // 비동기 팩토리 생성자
  static Future<EntryHandler> create() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = path.join(directory.path, 'entry.json');
    final handler = EntryHandler._(filePath);
    handler.loadEntrySync(); // 동기적으로 데이터 로드
    return handler;
  }

  // 동기적으로 데이터를 파일에서 로드
  Map<DateTime,String> loadEntrySync() {
    final file = File(filePath);

    // 파일이 없으면 빈 맵 반환
    if (!file.existsSync()) {
      print("파일이 존재하지 않습니다. 빈 데이터로 시작합니다.");
      _cachedData = {};
      return _cachedData;
    }

    try {
      // 파일에서 데이터를 읽어서 JSON 파싱
      final jsonString = file.readAsStringSync();
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      // String -> DateTime으로 변환
      _cachedData = jsonMap.map(
              (key, value) => MapEntry(DateTime.parse(key), value as String));
      print(jsonMap);
      print("데이터 로드 완료");
    } catch (e) {
      print('데이터 로드 중 오류 발생: $e');
      _cachedData = {};
    }
    return _cachedData;
  }

  // 동기적으로 데이터를 파일에 저장
  void _saveEntrySync() {
    final jsonData = _cachedData
        .map((key, value) => MapEntry(key.toIso8601String(), value));
    final file = File(filePath);

    try {
      // JSON 데이터를 파일에 저장
      file.writeAsStringSync(jsonEncode(jsonData));
      print("데이터 저장 완료");
    } catch (e) {
      print('데이터 저장 중 오류 발생: $e');
    }
  }

  // 데이터를 추가
  void addEntrySync(DateTime key, String value) {
    _cachedData[key] = value; // 새 데이터 추가
    _saveEntrySync(); // 동기적으로 데이터 저장
  }

  // 특정 키에 해당하는 데이터 반환
  String? getEntrySync(DateTime key) {
    return _cachedData[key];
  }
}
