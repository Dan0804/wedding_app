import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CreateCardApi {
  final String baseUrl = "http://localhost:8080/api/v1/cards";

  Future<bool> createCard(String cardTitle, int budget, DateTime deadline) async {
    String url = "localhost:8080";
    final response = await http.post(
      Uri.http(url, '/api/v1/cards'),
      body: json.encode({
        "cardTitle": cardTitle,
        "budget": budget,
        "deadline": deadline.toIso8601String(),
      }),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        'Accept': '*/*'
      },
    );
    if (response.statusCode == 201) {
      // Assuming 201 is the status code for a successful creation
      return true;
    } else {
      // Handle errors or unsuccessful responses
      if (kDebugMode) {
        print('Failed to create card: ${response.body}');
      }
      return false;
    }
  }
}
