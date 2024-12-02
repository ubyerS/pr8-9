import 'package:flutter/material.dart';
import '../models/game.dart';
import 'add_game_screen.dart';
import 'game_detail_screen.dart';

class GameStoreScreen extends StatelessWidget {
  final List<Game> games;
  final List<Game> favoriteGames;
  final Function(Game) toggleFavorite;
  final Function(Game) onAddToCart;
  final Function(Game) onAddGame;

  const GameStoreScreen({
    Key? key,
    required this.games,
    required this.toggleFavorite,
    required this.favoriteGames,
    required this.onAddToCart,
    required this.onAddGame,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GameStore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddGameScreen(onAdd: onAddGame),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 1.5,
  ),
  itemCount: games.length,
  itemBuilder: (context, index) {
    final game = games[index];
    final isFavorite = favoriteGames.contains(game);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailScreen(
              game: game,
              toggleFavorite: toggleFavorite,
              isFavorite: isFavorite,
              addToCart: onAddToCart,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: game.imagePath != null && game.imagePath!.isNotEmpty
                  ? Image.asset(game.imagePath!, fit: BoxFit.cover)
                  : Image.asset('assets/placeholder.jpg', fit: BoxFit.cover),
            ),
            ListTile(
              title: Text(game.name),
              subtitle: Text('${game.price} \$'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    onPressed: () => toggleFavorite(game),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => onAddToCart(game),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  },
),

    );
  }
}



