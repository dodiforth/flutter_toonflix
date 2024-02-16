import 'dart:convert';
import 'package:logger/logger.dart';

import 'package:flutter_toon/models/webtoon.dart';
import 'package:http/http.dart' as http;

final logger = Logger();

class ApiServices {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev/";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodayWebtoons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final toon = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(toon);
      }
      return webtoonInstances;
    } else {
      throw Exception('Failed to load webtoons');
    }
  }
}
