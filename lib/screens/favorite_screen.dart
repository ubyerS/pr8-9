import 'package:flutter/material.dart';
import 'dart:io';
import '../models/game.dart';
import 'game_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Game> favoriteGames;
  final Function(Game) toggleFavorite;
  final Function(Game) addToCart;

  const FavoriteScreen({
    super.key,
    required this.favoriteGames,
    required this.toggleFavorite,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: favoriteGames.isEmpty
          ? const Center(child: Text('Нет избранных игр'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
              ),
              itemCount: favoriteGames.length,
              itemBuilder: (context, index) {
                final game = favoriteGames[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameDetailScreen(
                          game: game,
                          toggleFavorite: toggleFavorite,
                          isFavorite: true,
                          addToCart: addToCart,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: game.imageFilePath != null && game.imageFilePath!.isNotEmpty? Image.file(
                            File(game.imageFilePath!),
                            fit: BoxFit.cover,)
                            : (game.imagePath != null && game.imagePath!.isNotEmpty? Image.asset(game.imagePath!,
                            fit: BoxFit.cover): const Icon(Icons.image_not_supported, size: 50,)),),

                        ListTile(
                          title: Text(game.name),
                          subtitle: Text('${game.price} \$'),
                          trailing: IconButton(
                            icon: const Icon(Icons.favorite),
                            onPressed: () => toggleFavorite(game),
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
