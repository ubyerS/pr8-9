import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/game.dart';

class ApiService {
  final String _baseUrl = 'http://localhost:8080';

  Future<List<Game>> fetchGames() async {
    final response = await http.get(Uri.parse('http://localhost:8080/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Game.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load games');
    }
  }

  Future<Game> createGame(Game game) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(game.toJson()),
    );

    if (response.statusCode == 201) {
      return Game.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add game');
    }
  }
}


