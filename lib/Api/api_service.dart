import 'dart:convert';

import 'package:account_book2/Model/api_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //static String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  //static final String today = "today";

  static String baseUrl = "http://192.168.10.71:3000";
  //static String baseUrl = "http://10.0.2.2:3000";
  static final String user = "user";

  /* SELECT */
  // 메서드 생성
  // 비동기적으로 처리되는 웹툰 데이터 목록을 포함하는 Future 객체를 반환
  static Future<List<ApiModel>> getApiData() async {
    List<ApiModel> apiInstances = [];
    final url = Uri.parse('$baseUrl/$user');
    // async 함수 내에서만 await 사용 가능
    // Future 타입은 미래에 완료됨
    // http.get(url) : API 서버에 요청을 보냄
    // await : 서버에서 요청하고 처리하고 응답주는걸 기다림
    // 응답을 response 변수에 저장함
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // jsonDecode : string 형식을 json 형태로 변환
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        apiInstances.add(ApiModel.fromJson(webtoon));
      }
      return apiInstances;
    }
    throw Error();
  }

  /* CREATE */
  static Future<void> createData({
    required String date,
    required String dayOfWeek,
    required String category,
    required String description,
    required String time,
    required String bank,
    required int income,
    required int expense,
    required String fulldate,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$user'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'date': date,
          'dayOfWeek': dayOfWeek,
          'category': category,
          'description': description,
          'time': time,
          'bank': bank,
          'income': income,
          'expense': expense,
          'fulldate': fulldate,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to create data');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  /* UPDATE */
  static Future<void> updateDate({
    required int id,
    required String date,
    required String dayOfWeek,
    required String category,
    required String description,
    required String time,
    required String bank,
    required int income,
    required int expense,
    required String fulldate,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$user/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'date': date,
        'dayOfWeek': dayOfWeek,
        'category': category,
        'description': description,
        'time': time,
        'bank': bank,
        'income': income,
        'expense': expense,
        'fulldate': fulldate,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create data');
    }
  }
}
