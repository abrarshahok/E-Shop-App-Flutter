import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/constants/constants.dart';
import '/models/cart_item.dart';
import '/providers/cart_provider.dart';
import '/providers/order_provider.dart';
import '../../widgets/cart/cart_items.dart';
import '../../widgets/order/add_order_info_form.dart';

class AddOrderInfoScreen extends StatefulWidget {
  static const routeName = '/order-info-screen';
  const AddOrderInfoScreen({super.key});

  @override
  State<AddOrderInfoScreen> createState() => _AddOrderInfoScreenState();
}

class _AddOrderInfoScreenState extends State<AddOrderInfoScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final order =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final double total = order['total'];
    final List<CartItem> products = order['cartItem'];
    final navigator = Navigator.of(context);
    final cart = Provider.of<CartProvider>(context);
    final cartValues = cart.cartItems.values.toList();

    void submitDeliveryInfo({
      required String firstName,
      required String lastName,
      required String address,
    }) async {
      try {
        setState(() => isLoading = true);
        await Provider.of<OrderProvider>(context, listen: false).addOrder(
          totalPrice: total,
          customerName: '$firstName $lastName',
          deliveryAddress: address,
          cartItem: products,
        );
        cart.clearCart();
        navigator.pop();
      } catch (_) {
        setState(() => isLoading = false);
      }
    }

    return Scaffold(
      appBar: appBar('Confirm Your Order'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AddOrderInfoForm(
            submit: submitDeliveryInfo,
            isLoading: isLoading,
          ),
          const Text(
            'Your Cart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCount,
              itemBuilder: (ctx, index) {
                final productId = cart.cartItems.keys.toList()[index];
                return CartItems(
                  productId: productId,
                  quantity: cartValues[index].quantity,
                  showCartButtons: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
