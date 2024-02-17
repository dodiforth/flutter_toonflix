import 'dart:convert';
import 'package:logger/logger.dart';

import 'package:flutter_toon/models/webtoon.dart';
import 'package:flutter_toon/models/webtoon_detail.dart';
import 'package:flutter_toon/models/webtoon_episode.dart';
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

  static Future<WebtoonDetailModel> getWebtoonById(String id) async {
    final url = Uri.parse('$baseUrl$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    } else {
      throw Exception('Failed to load selected webtoon');
    }
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodeById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        final latestEpisode = WebtoonEpisodeModel.fromJson(episode);
        episodesInstances.add(latestEpisode);
      }
      return episodesInstances;
    } else {
      throw Exception('Failed to load selected webtoon episodes');
    }
  }
}
