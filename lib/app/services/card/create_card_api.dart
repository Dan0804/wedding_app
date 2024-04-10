import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateCardApi {

  Future<bool> createCard(String cardTitle, int budget, DateTime deadline) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = "localhost:8080";
    final response = await http.post(
      Uri.http(url, '/api/v1/cards'),
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
      // Assuming 201 is the status code for a successful creation
      return true;
    } else {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonBody = json.decode(decodedBody);

      throw Exception(
            'Failed to create card: '
            'Status code: ${response.statusCode} '
            'Response body: $jsonBody'
      );
    }
  }
}
