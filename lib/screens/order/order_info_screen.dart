import 'package:eshop_flutter_app/models/cart_item.dart';
import 'package:eshop_flutter_app/providers/cart_item_provider.dart';
import 'package:eshop_flutter_app/providers/order_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/order/order_info_form.dart';

class OrderInfoScreen extends StatefulWidget {
  static const routeName = '/order-info-screen';
  const OrderInfoScreen({super.key});

  @override
  State<OrderInfoScreen> createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final order =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final double total = order['total'];
    final List<CartItem> products = order['cartItem'];
    bool isLoading = false;
    final navigator = Navigator.of(context);
    final cart = Provider.of<CartItemProvider>(context, listen: false);

    void submitDeliveryInfo({
      required String firstName,
      required String lastName,
      required String address,
    }) async {
      try {
        setState(() => isLoading = true);
        await Provider.of<OrderItemProvider>(context, listen: false).addOrder(
          totalPrice: total,
          customerName: '$firstName $lastName',
          deliveryAddress: address,
          cartItem: products,
        );
        navigator.pop();
        cart.clearCart();
      } catch (_) {
        setState(() => isLoading = false);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: const Text('Confirm Your Order'),
      ),
      body: OrderInfoForm(
        submit: submitDeliveryInfo,
        isLoading: isLoading,
      ),
    );
  }
}
