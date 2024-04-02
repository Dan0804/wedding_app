import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/tile.dart';

Future<List<Tile>> fetchTileApi(String status) async {
  final response = await http.get(Uri.parse('http://localhost:8080/api/v1/cards/status/$status'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => Tile.fromJson(json)).toList();
  } else {
    throw Exception(
        'Failed to load tiles from the API. '
        'Status code: ${response.statusCode} '
        'Response body: ${json.decode(response.body)}'
    );
  }
}
