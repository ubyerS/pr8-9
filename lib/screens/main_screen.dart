import 'package:flutter/material.dart';
import 'game_store_screen.dart';
import 'favorite_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import '../models/game.dart';
import '../widgets/bottom_navigation.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Game> favoriteGames = [];
  List<CartItem> cartItems = [];

  List<Game> games = [
  Game(
    name: 'Forza Horizon 4',
    description: 'Гоночная игра в открытом мире.',
    price: 49.99,
    imagePath: 'assets/forza.jpg',
  ),
  Game(
    name: 'Stardew Valley',
    description: 'Симулятор фермы и ролевой игры.',
    price: 14.99,
    imagePath: 'assets/stardew_valley.jpg',
  ),

];


  void toggleFavorite(Game game) {
    setState(() {
      favoriteGames.contains(game) ? favoriteGames.remove(game) : favoriteGames.add(game);
    });
  }

  void _addToCart(Game game) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) => item.game == game,
        orElse: () => CartItem(game, 0),
      );
      if (existingItem.quantity == 0) {
        cartItems.add(CartItem(game, 1));
      } else {
        existingItem.quantity++;
      }
    });
  }

  void _addNewGame(Game game) {
    setState(() {
      games.add(game);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      GameStoreScreen(
        games: games,
        toggleFavorite: toggleFavorite,
        favoriteGames: favoriteGames,
        onAddToCart: _addToCart,
        onAddGame: _addNewGame,
      ),
      FavoriteScreen(
        favoriteGames: favoriteGames,
        toggleFavorite: toggleFavorite,
        addToCart: _addToCart,
      ),
      CartScreen(cartItems: cartItems),
      ProfileScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTabTapped: (index) => setState(() => _currentIndex = index),
        favoriteCount: favoriteGames.length,
        cartCount: cartItems.length,
      ),
    );
  }
}
