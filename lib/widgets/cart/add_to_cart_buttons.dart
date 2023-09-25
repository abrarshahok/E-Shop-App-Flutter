import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/product_provider.dart';
import '../../providers/cart_provider.dart';

class AddToCartButtons extends StatelessWidget {
  const AddToCartButtons({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Row(
      children: [
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
          child: Consumer<CartProvider>(
            builder: (context, cart, child) => Text(
              '${cart.cartItems[productId]?.quantity ?? 0}',
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            int cartItemQuantity = cart.cartItems[productId]?.quantity ?? 0;
            if (product.stock <= cartItemQuantity) {
              return;
            }
            cart.addItem(
              productId: productId,
              title: product.title,
              imageUrl: product.image,
              price: product.price,
            );
          },
          icon: const Icon(Icons.add),
          color: Colors.grey,
        ),
      ],
    );
  }
}
