import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/constants/constants.dart';
import '../../animations/loading_cart.dart';
import '../../widgets/cart/place_order.dart';
import '/widgets/cart/cart_items.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future? _future;

  Future _fetchFutureCartItems() {
    return Provider.of<CartProvider>(context, listen: false).fetchCartItems();
  }

  @override
  void initState() {
    _future = _fetchFutureCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartValues = cart.cartItems.values.toList();
    return cart.itemsCount <= 0
        ? notFound('Cart is Empty!')
        : FutureBuilder(
            future: _future,
            builder: (ctx, futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return const LoadingCart();
              }
              return Column(
                children: [
                  PlaceOrder(
                    cart: cart,
                    cartValues: cartValues,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.itemsCount,
                      itemBuilder: (ctx, index) {
                        final productId = cart.cartItems.keys.toList()[index];
                        return CartItems(
                          productId: productId,
                          quantity: cartValues[index].quantity,
                          showCartButtons: true,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
  }
}
