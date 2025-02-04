import 'dart:convert';

import 'package:account_book2/Model/api_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //static String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  //static final String today = "today";

  static String baseUrl = "http://192.168.10.14:3000";
  //static String baseUrl = "http://192.168.219.145:3000";
  //static String baseUrl = "http://10.0.2.2:3000";
  static String user = "user";
  static String select = "select";
  static String create = "create";
  static String update = "update";
  static String delete = "delete";
  static String login = "login";

  /* SELECT */
  // 메서드 생성
  // 비동기적으로 처리되는 웹툰 데이터 목록을 포함하는 Future 객체를 반환
  static Future<List<ApiModel>> getApiData() async {
    List<ApiModel> apiInstances = [];
    // 요청할 서버 URL 구성
    final url = Uri.parse('$baseUrl/$user/$select');
    // async 함수 내에서만 await 사용 가능
    // http.get(url) : API 서버에 요청을 보냄
    // await : 서버에서 요청하고 처리하고 응답주는걸 기다림
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // jsonDecode : string 형식을 json 형태로 변환
      final List<dynamic> webtoons = jsonDecode(response.body);
      return webtoons.map((e) => ApiModel.fromJson(e)).toList();
    }
    throw Error();
  }

  /* CREATE */
  // 클래스 인스턴스를 생성하지 않고 사용
  // 비동기 작업을 다룰 때 사용되는 타입 (예: HTTP 요청, 파일 입출력 등)
  static Future<void> createData({
    // 필드 선언
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
      // http.post : 새로운 데이터 생성
      final response = await http.post(
        // 요청할 서버 URL 구성
        Uri.parse('$baseUrl/$user/$create'),
        // 요청 헤더 : 서버에 보낼 데이터의 타입 JSON 형식임을 알 수 있게 설정
        headers: {'Content-Type': 'application/json'},
        // 요청 본문 : 서버에 전송할 데이터 JSON 형식으로 변환
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
  // 클래스 인스턴스를 생성하지 않고 사용
  // 비동기 작업을 다룰 때 사용되는 타입 (예: HTTP 요청, 파일 입출력 등)
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
    // http.put : 기존 리소스 수정
    final response = await http.put(
      // 요청할 서버 URL 구성
      Uri.parse('$baseUrl/$user/$update/$id'),
      // 요청 헤더 : 서버에 보낼 데이터의 타입 JSON 형식임을 알 수 있게 설정
      headers: {'Content-Type': 'application/json'},
      // 요청 본문 : 서버에 전송할 데이터 JSON 형식으로 변환
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
    // 서버로부터 받은 응답 상태 코드 확인
    if (response.statusCode != 200) {
      throw Exception('Failed to create data');
    }
  }

  /* DELETE */
  // 클래스 인스턴스를 생성하지 않고 사용
  // 비동기 작업을 다룰 때 사용되는 타입 (예: HTTP 요청, 파일 입출력 등)
  static Future<void> deleteData(int id) async {
    // http.delete : 데이터 삭제
    final response = await http.delete(
      // 요청할 서버 URL 구성
      Uri.parse('$baseUrl/$user/$delete/$id'),
    );
    // 서버로부터 받은 응답 상태 코드 확인
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  /* 로그인 조회 */
  // 클래스 인스턴스를 생성하지 않고 사용
  // 비동기 작업을 다룰 때 사용되는 타입 (예: HTTP 요청, 파일 입출력 등)
  static Future<bool> userCheck({
    required String username,
    required String password,
  }) async {
    try {
      // http.put : 기존 리소스 수정
      final response = await http.post(
        // 요청할 서버 URL 구성
        Uri.parse('$baseUrl/$user/$login'),
        // 요청 헤더 : 서버에 보낼 데이터의 타입 JSON 형식임을 알 수 있게 설정
        headers: {'Content-Type': 'application/json'},
        // 요청 본문 : 서버에 전송할 데이터 JSON 형식으로 변환
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      // 서버로부터 받은 응답 상태 코드 확인
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] ?? false;
        //throw Exception('Failed to create data');
      } else
        return false;
    } catch (e) {
      print('로그인 오류: $e');
      return false;
    }
  }
}
