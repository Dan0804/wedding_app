import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tile.dart';
import '../../util/config.dart';

const String _baseUrl = Config.apiUrl;

class TileService extends ChangeNotifier {
  late Map<DateTime, List<Tile>> calendarTiles;
  late List<Tile> tilesForDay = [];
  late DateTime selectedDay;

  void getTilesForDay(day) {
    tilesForDay = calendarTiles[day] ?? [];
    selectedDay = day;
    notifyListeners();
  }

  void firstGetTilesForDay(day) {
    tilesForDay = calendarTiles[day] ?? [];
    selectedDay = day;
  }

  Future<List<Tile>> getTileApi(String cardStatus) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$_baseUrl/cardboard/$cardStatus'),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
        'Accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Tile.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tiles from the API. '
          'Status code: ${response.statusCode} '
          'Response body: ${json.decode(response.body)}');
    }
  }

  Future<List> fetchAllTiles() async {
    var values = Future.wait([
      getTileApi('BACKLOG'),
      getTileApi('PROGRESS'),
      getTileApi('DONE'),
    ]);

    return values;
  }

  void calendarDatas(List<Tile> datas) {
    for (Tile data in datas) {
      var date = DateTime.utc(data.deadline.year, data.deadline.month, data.deadline.day);
      if (calendarTiles.containsKey(date)) {
        calendarTiles[date]!.add(data);
      } else {
        calendarTiles[date] = [data];
      }
    }
  }

  Future<bool> createCard(String cardTitle, int budget, DateTime deadline) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$_baseUrl/cards'),
      body: json.encode({
        "cardTitle": cardTitle,
        "budget": budget,
        "deadline": deadline.toIso8601String(),
      }),
      headers: {
        'Authorization': 'Bearer $token',
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        'Accept': '*/*',
      },
    );

    if (response.statusCode == 201) {
      notifyListeners();
      return true;
    } else {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonBody = json.decode(decodedBody);

      throw Exception('Failed to create card: '
          'Status code: ${response.statusCode} '
          'Response body: $jsonBody');
    }
  }

  Future<bool> editTile(int tileId, Map<String, dynamic> editData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.patch(
      Uri.parse('$_baseUrl/cardboard/$tileId'),
      body: json.encode(editData),
      headers: {
        'Authorization': 'Bearer $token',
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        'Accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    } else {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonBody = json.decode(decodedBody);

      throw Exception('Failed to create card: '
          'Status code: ${response.statusCode} '
          'Response body: $jsonBody');
    }
  }

  Future<bool> deleteTile(int tileId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('$_baseUrl/cardboard/$tileId'),
      body: json.encode({
        "cardId": tileId,
      }),
      headers: {
        'Authorization': 'Bearer $token',
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        'Accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    } else {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonBody = json.decode(decodedBody);

      throw Exception('Failed to create card: '
          'Status code: ${response.statusCode} '
          'Response body: $jsonBody');
    }
  }
}
