import 'package:eshop_flutter_app/providers/product_provider.dart';
import 'package:eshop_flutter_app/widgets/cart/add_to_cart_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItems extends StatelessWidget {
  final String productId;
  final int quantity;
  final bool showCartButtons;

  const CartItems({
    super.key,
    required this.productId,
    required this.quantity,
    this.showCartButtons = false,
  });
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);
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
                product.image,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Only ${product.stock} item(s) in stock',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Price: \$${product.price}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            if (showCartButtons) ...[
              AddToCartButtons(productId: productId),
            ] else
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Text(
                  'Qty: $quantity',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
