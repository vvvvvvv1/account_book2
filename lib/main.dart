import 'package:account_book2/Login.dart';
import 'package:account_book2/Login2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // Flutter 엔진 초기화
  WidgetsFlutterBinding.ensureInitialized();
  // 날짜 포맷 초기화
  await initializeDateFormatting();
  runApp(
    const MyApp(),
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
      home: Login2(),
    );
  }
}
