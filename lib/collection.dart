import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  // 서버에서 가져온 월별 고구마 이미지 데이터를 저장할 Map
  Map<int, String> collectedPotatoes = {};

  @override
  void initState() {
    super.initState();
    // 서버에서 데이터 가져오기
    _fetchPotatoCollection();
  }

  // 서버에서 고구마 컬렉션 데이터를 가져오는 함수
  Future<void> _fetchPotatoCollection() async {
    // TODO: 서버에서 데이터를 가져와서 collectedPotatoes에 저장
    // 예시:
    // collectedPotatoes = await 서버에서_데이터가져오기();
    // 형식은 {5: 'images/may_potato.png', 7: 'images/july_potato.png', ...}

    // 아래는 테스트용 데이터입니다. 실제 서버 데이터로 교체해야 합니다.
    collectedPotatoes = {
      5: 'images/3.png',
      7: 'images/5.png',
      9: 'images/3.png',
      11: 'images/4.png',
    };

    // 데이터가 로드된 후 화면 갱신
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                "고구마 컬렉션",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Nanum SeongSirCe',
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  int month = index + 1;
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[700],
                        backgroundImage: collectedPotatoes.containsKey(month)
                            ? AssetImage(collectedPotatoes[month]!)
                            : null,
                        child: collectedPotatoes.containsKey(month)
                            ? null
                            : Icon(
                          Icons.hourglass_empty,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "$month월",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Nanum SeongSirCe',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
