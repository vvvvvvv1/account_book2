import 'package:account_book2/BottomPage/FouthPage.dart';
import 'package:account_book2/BottomPage/SecondPage.dart';
import 'package:account_book2/BottomPage/ThirdPage.dart';
import 'package:account_book2/Class/TransactionService.dart';
import 'package:account_book2/BottomPage/FirstPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  await initializeDateFormatting();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Transactionservice()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 디버그 배너 없애기
      debugShowCheckedModeBanner: false,
      routes: {
        // /main : 경로 이름 (이 경로를 통해 특정 화면 네비게이션)
        // (context) => MyApp() : 이 경로가 호출되면 MyApp 위젯이 생성됨
        // ex) Navigator.pushNamed(context, '/main); 이 호출되면 /main 경로에 해당하는 MyApp 위젯 표시
        // 네비게이션 설정할 때 사용 (특정 경로를 위젯과 연결)
        '/main': (context) => MyApp(),
      },
      home: Scaffold(
        // 제공된 인덱스에 따라 한 번에 하나의 자식만 표시하는 위젯
        body: IndexedStack(
          /// 보여주려는 페이지 index
          index: currentIndex,

          /// 보여줄 수 있는 모든 페이지 위젯 리스트
          children: const [
            FirstPage(),
            SecondPage(),
            ThirdPage(),
            FourthPage(),
          ],
        ),
        // 네비게이션 바 화면 하단 표시
        bottomNavigationBar: BottomNavigationBar(
          // 현재 선택된 탭 인덱스
          currentIndex: currentIndex,
          // 탭할 때 호출
          // newIndex : 선택된 탭 인덱스
          onTap: (newIndex) {
            print('selected newIndex : $newIndex');
            // 상태 업데이트
            setState(() {
              currentIndex = newIndex;
            });
          },
          selectedItemColor: Colors.red, // 선택된 아이콘 색상
          unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
          //showSelectedLabels: false,          // 선택된 항목 label 숨기기
          //showUnselectedLabels: false,        // 선택되지 않은 항목 label 숨기기
          type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined), label: "가계부"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined), label: "통계"),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money_outlined), label: "자산"),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "더보기"),
          ],
        ),
      ),
    );
  }
}
