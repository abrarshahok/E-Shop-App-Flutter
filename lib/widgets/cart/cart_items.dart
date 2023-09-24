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
  final bool showQty;

  const CartItems({
    super.key,
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
    required this.stock,
    this.showQty = false,
  });
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItemProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        child: Row(
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
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  if (showQty)
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
            ),
            const Spacer(),
            if (showQty) ...[
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
            ] else
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Text(
                  'x $quantity',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
