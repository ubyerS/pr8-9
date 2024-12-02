import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/game.dart';

class CartItem {
  final Game game;
  int quantity;

  CartItem(this.game, this.quantity);
}


class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _removeItem(CartItem item) {
    setState(() {
      widget.cartItems.remove(item);
    });
  }

  void _incrementQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void _decrementQuantity(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        _removeItem(item);
      }
    });
  }

  double _calculateTotal() {
    return widget.cartItems.fold(
      0,
      (total, item) => total + item.game.price * item.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Корзина пуста'))
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Slidable(
                  key: ValueKey(item.game.name),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => _removeItem(item),
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Удалить',
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: item.game.imagePath != null && item.game.imagePath!.isNotEmpty? Image.asset(
                      item.game.imagePath!,
                      width: 50,
                      fit: BoxFit.cover,)
                      : const Icon(Icons.image_not_supported, size: 50),
                    title: Text(item.game.name),
                    subtitle: Text('${item.game.price} \$'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _decrementQuantity(item),
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _incrementQuantity(item),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Итог: ${_calculateTotal().toStringAsFixed(2)} \$',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
