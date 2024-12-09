import 'package:flutter/material.dart';

class Transaction {
  final String date;
  final String dayOfWeek;
  final String category;
  final String description;
  final String time;
  final String bank;
  final int income;
  final int expense;

  Transaction({
    required this.date,
    required this.dayOfWeek,
    required this.category,
    required this.description,
    required this.time,
    required this.bank,
    required this.income,
    required this.expense,
  });
}

/// Bucket 담당
class Transactionservice extends ChangeNotifier {
  List<Transaction> TransactionList = [
    Transaction(
      date: "01", // 날짜
      dayOfWeek: "일요일", // 요일
      category: "교통/차량", // 카테고리
      description: "테스트", // 내용
      time: "오후 3:16", // 시간
      bank: "신한은행", // 장소/은행
      income: 0, // 수입
      expense: 0, // 지출
    ),
  ];

  void CreateTransaction(String date, String dayOfWeek, String category,
      String description, String time, String bank, int income, int expense) {
    TransactionList.add(Transaction(
        date: date,
        dayOfWeek: dayOfWeek,
        category: category,
        description: description,
        time: time,
        bank: bank,
        income: income,
        expense: expense));
    notifyListeners();
  }
}
