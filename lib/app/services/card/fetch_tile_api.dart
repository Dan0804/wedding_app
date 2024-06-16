import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/tile.dart';
import '../../../config.dart';

const String _baseUrl = Config.apiUrl;

class FetchTileApi extends ChangeNotifier {
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
}
