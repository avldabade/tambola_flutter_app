import 'dart:async';
import 'dart:convert';
import 'package:tambola/constants/constants.dart';
import 'package:tambola/model/grid_view_model.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<List<HomeCellVO>> fetchHomeData() async {
    final response = await http.get(Constant.HOME_SERVICE_URL);
    print('response::: $response');
    if (response.statusCode == 200) {
      List<HomeCellVO> list = parsePostsForHome(response.body);
      return list;
    } else {
      throw Exception(Constant.INTERNET_ERROR);
    }
  }

  static List<HomeCellVO> parsePostsForHome(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HomeCellVO>((json) => HomeCellVO.fromJson(json)).toList();
  }
}