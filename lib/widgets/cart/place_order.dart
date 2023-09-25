import 'package:flutter/material.dart';
import '../../screens/order/add_order_info_screen.dart';
import '../../providers/cart_provider.dart';
import '../../models/cart_item.dart';

class PlaceOrder extends StatelessWidget {
  final CartProvider cart;
  final List<CartItem> cartValues;

  const PlaceOrder({
    super.key,
    required this.cart,
    required this.cartValues,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text(
                  'Total Bill',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    '\$${cart.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.grey[800],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AddOrderInfoScreen.routeName,
                arguments: {
                  'total': cart.total,
                  'cartItem': cartValues,
                },
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
              ),
              child: const Text(
                'Place Order',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
