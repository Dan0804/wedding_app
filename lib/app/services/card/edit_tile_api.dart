import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config.dart';

class EditTileApi {
  final String _baseUrl = Config.apiUrl;

  Future<bool> editTile(int tileId, String tileTitle, int budget, DateTime deadline, String tileStatus) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$_baseUrl/cardboard/$tileId'),
      body: json.encode({
        "cardTitle": tileTitle,
        "budget": budget,
        "deadline": deadline.toIso8601String(),
        "cardStatus": tileStatus,
      }),
      headers: {
        'Authorization': 'Bearer $token',
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        'Accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
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
