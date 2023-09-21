import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_item_provider.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final String image;
  final int quantity;
  final int stock;

  const CartItems({
    super.key,
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
    required this.stock,
  });
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItemProvider>(context, listen: false);
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.all(20),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 3),
              Text(
                'Only $stock item(s) in stock',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: \$$price',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () => cart.removeItem(productId: productId),
            icon: const Icon(Icons.remove),
            color: Colors.grey,
          ),
          Container(
            height: 25,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Consumer<CartItemProvider>(
              builder: (context, cart, child) => Text(
                '${cart.cartItems[productId]?.quantity ?? 0}',
              ),
            ),
          ),
          IconButton(
            onPressed: () => cart.addItem(
              productId: productId,
              title: title,
              imageUrl: image,
              price: price,
            ),
            icon: const Icon(Icons.add),
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
