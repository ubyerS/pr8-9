import 'package:flutter/material.dart';
import '../api_service.dart';
import '../models/game.dart';

class ApiTestScreen extends StatefulWidget {
  @override
  _ApiTestScreenState createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  final ApiService _apiService = ApiService();
  List<Game> _games = [];
  bool _isLoading = false;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  Future<void> _fetchGames() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });
    try {
      List<Game> games = await _apiService.fetchGames();
      setState(() {
        _games = games;
        _message = 'Games loaded successfully!';
      });
    } catch (e) {
      setState(() {
        _message = 'Failed to load games: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addGame() async {
    final game = Game(
      name: 'New Game',
      description: 'A new game description',
      price: 29.99,
      imagePath: 'https://example.com/image.jpg',
      imageFilePath: null,
    );
    setState(() {
      _isLoading = true;
      _message = '';
    });
    try {
      Game createdGame = await _apiService.createGame(game);
      setState(() {
        _games.add(createdGame);
        _message = 'Game added successfully!';
      });
    } catch (e) {
      setState(() {
        _message = 'Failed to add game: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Test Screen')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text(_message),
                ElevatedButton(
                  onPressed: _fetchGames,
                  child: Text('Fetch Games'),
                ),
                ElevatedButton(
                  onPressed: _addGame,
                  child: Text('Add Game'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _games.length,
                    itemBuilder: (context, index) {
                      final game = _games[index];
                      return ListTile(
                        title: Text(game.name),
                        subtitle: Text('${game.price} \$'),
                        leading: game.imagePath != null
                            ? Image.network(game.imagePath!)
                            : Icon(Icons.image),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

