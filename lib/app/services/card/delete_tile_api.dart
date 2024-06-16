import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config.dart';

class DeleteTileApi extends ChangeNotifier {
  final String _baseUrl = Config.apiUrl;

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
