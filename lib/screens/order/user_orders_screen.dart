import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/constants/constants.dart';
import '../../animations/loading_orders.dart';
import '../../widgets/order/user_order_items.dart';
import '../../providers/order_provider.dart';

class UserOrdersScreen extends StatefulWidget {
  const UserOrdersScreen({super.key});

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  Future? futureOrders;

  Future getFutureOrders() {
    return Provider.of<OrderProvider>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    futureOrders = getFutureOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
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
                itemBuilder: (ctx, index) => UserOrderItems(
                  order: orderData.orders[index],
                ),
              );
            },
          );
  }
}
