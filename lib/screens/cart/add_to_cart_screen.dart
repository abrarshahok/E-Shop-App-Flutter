import '/providers/cart_item_provider.dart';
import '/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartScreen extends StatelessWidget {
  const AddToCartScreen({super.key});
  static const routeName = '/add-to-cart-screen';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);
    final cart = Provider.of<CartItemProvider>(context, listen: false);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 150,
                width: 200,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.network(
                    product.image,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.black12),
          Row(
            children: [
              const Text(
                'Item(s) available in stock',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Text(
                '${product.stock}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const Divider(color: Colors.black12),
          Row(
            children: [
              const Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 18,
                ),
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
                  title: product.title,
                  imageUrl: product.image,
                  price: product.price,
                ),
                icon: const Icon(Icons.add),
                color: Colors.grey,
              ),
            ],
          ),
          const Divider(color: Colors.black12),
          const Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.white,
              fixedSize: const Size(300, 30),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
