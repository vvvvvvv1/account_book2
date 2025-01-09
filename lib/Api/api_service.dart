import 'dart:convert';

import 'package:account_book2/Model/api_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static final String today = "today";

  // 메서드 생성
  // 비동기적으로 처리되는 웹툰 데이터 목록을 포함하는 Future 객체를 반환
  static Future<List<ApiModel>> getTodaysToons() async {
    List<ApiModel> apiInstances = [];
    final url = Uri.parse('$baseUrl/$today');
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
}
