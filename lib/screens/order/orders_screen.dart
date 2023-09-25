import 'package:eshop_flutter_app/constants/constants.dart';
import '../../animations/loading_orders.dart';
import '/widgets/order/order_items.dart';
import '/providers/order_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future? futureOrders;

  Future getFutureOrders() {
    return Provider.of<OrderItemProvider>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    futureOrders = getFutureOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderItemProvider>(context);
    return orderData.itemCount <= 0
        ? notFound('No orders added yet!')
        : FutureBuilder(
            future: futureOrders,
            builder: (ctx, futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return const LoadingOrders();
              }
              return ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, index) => OrderItems(
                  order: orderData.orders[index],
                ),
              );
            },
          );
  }
}
