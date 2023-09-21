import '/widgets/order/order_items.dart';
import '/providers/order_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderItemProvider>(context, listen: false);
    return orderData.itemCount <= 0
        ? const Center(
            child: Text('No orders added yet!'),
          )
        : FutureBuilder(
            future: orderData.fetchOrders(),
            builder: (ctx, futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
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
