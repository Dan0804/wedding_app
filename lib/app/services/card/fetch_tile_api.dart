import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/tile.dart';
import '../../../config.dart';

const String _baseUrl = Config.apiUrl;

class FetchTileApi extends ChangeNotifier {
  List<Tile> backlogTiles = [];
  List<Tile> progressTiles = [];
  List<Tile> doneTiles = [];

  Future<void> fetchAllTiles() async {
    await Future.wait([
      fetchTilesByStatus('BACKLOG'),
      fetchTilesByStatus('PROGRESS'),
      fetchTilesByStatus('DONE'),
    ]);
    notifyListeners();
  }

  Future<void> fetchTilesByStatus(String cardStatus) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/cardboard/$cardStatus'),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      _processTileData(cardStatus, jsonList);
    } else {
      throw Exception('Failed to load tiles from the API.'
          'Status code: ${response.statusCode}'
          'Response body: ${json.decode(response.body)}');
    }
  }

  void _processTileData(String cardStatus, List<dynamic> jsonList) {
    final List<Tile> tiles = jsonList.map((json) => Tile.fromJson(json)).toList();

    switch (cardStatus) {
      case 'BACKLOG':
        backlogTiles = tiles;
        break;
      case 'PROGRESS':
        progressTiles = tiles;
        break;
      case 'DONE':
        doneTiles = tiles;
        break;
    }
  }

  Future<void> updateTileStatus(Tile tile, String newStatus) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/cardboard/${tile.tileId}'),
      headers: await _headers(),
      body: json.encode({'cardStatus': newStatus}),
    );

    if (response.statusCode == 200) {
      _updateLocalTileStatus(tile, newStatus);
      notifyListeners();
    } else {
      throw Exception('Failed to update tile status.');
    }
  }

  void _updateLocalTileStatus(Tile tile, String newStatus) {
    // 이전 상태에서 제거
    switch (tile.tileStatus) {
      case 'BACKLOG':
        backlogTiles.removeWhere((t) => t.tileId == tile.tileId);
        break;
      case 'PROGRESS':
        progressTiles.removeWhere((t) => t.tileId == tile.tileId);
        break;
      case 'DONE':
        doneTiles.removeWhere((t) => t.tileId == tile.tileId);
        break;
    }

    // 타일의 상태 업데이트
    final updatedTile = Tile(
      tileId: tile.tileId,
      tileTitle: tile.tileTitle,
      budget: tile.budget,
      deadline: tile.deadline,
      tileStatus: newStatus,
    );

    // 새로운 상태로 추가
    switch (newStatus) {
      case 'BACKLOG':
        backlogTiles.add(updatedTile);
        break;
      case 'PROGRESS':
        progressTiles.add(updatedTile);
        break;
      case 'DONE':
        doneTiles.add(updatedTile);
        break;
    }
  }

  Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}
