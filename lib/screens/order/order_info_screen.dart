import 'package:eshop_flutter_app/constants/constants.dart';
import 'package:eshop_flutter_app/models/cart_item.dart';
import 'package:eshop_flutter_app/providers/cart_item_provider.dart';
import 'package:eshop_flutter_app/providers/order_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/cart/cart_items.dart';
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
    final cart = Provider.of<CartItemProvider>(context);
    final cartValues = cart.cartItems.values.toList();
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
      appBar: appBar('Confirm Your Order'),
      body: Column(
        children: [
          OrderInfoForm(
            submit: submitDeliveryInfo,
            isLoading: isLoading,
          ),
          const Text(
            'Your Cart',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, product, child) => ListView.builder(
                itemCount: cart.itemsCount,
                itemBuilder: (ctx, index) {
                  final productId = cart.cartItems.keys.toList()[index];
                  final stock = product.findById(productId).stock;
                  return CartItems(
                    id: cartValues[index].id,
                    productId: productId,
                    title: cartValues[index].title,
                    price: cartValues[index].price,
                    image: cartValues[index].image,
                    stock: stock,
                    quantity: cartValues[index].quantity,
                    showQty: false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
