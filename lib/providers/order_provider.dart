import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/cart_item.dart';
import '/models/order_item.dart';

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  int get itemCount => _orders.length;

  Future<void> fetchOrders() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final fetchedOrders = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();
      final orderInfo = fetchedOrders.docs;
      final List<OrderItem> loadedOrders = [];

      for (var item in orderInfo) {
        loadedOrders.insert(
          0,
          OrderItem(
            id: item.id,
            amount: item['amount'],
            customerName: item['name'],
            deliveryAddress: item['address'],
            dateTime: DateTime.parse(item['dateTime']),
            products: (item['products'] as List<dynamic>)
                .map(
                  (cartItem) => CartItem(
                    id: cartItem['id'],
                    title: cartItem['title'],
                    image: cartItem['image'],
                    price: cartItem['price'],
                    quantity: cartItem['quantity'],
                  ),
                )
                .toList(),
          ),
        );
        _orders = loadedOrders;
      }
      _orders.sort(((a, b) => b.dateTime.compareTo(a.dateTime)));
    } catch (_) {
      rethrow;
    }

    notifyListeners();
  }

  Future<void> addOrder({
    required double totalPrice,
    required String customerName,
    required String deliveryAddress,
    required List<CartItem> cartItem,
  }) async {
    if (cartItem.isEmpty || totalPrice == 0.0) {
      return;
    }
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final insertedOrder =
          await FirebaseFirestore.instance.collection('orders').add({
        'amount': totalPrice,
        'name': customerName,
        'address': deliveryAddress,
        'products': cartItem
            .map((product) => {
                  'id': product.id,
                  'title': product.title,
                  'image': product.image,
                  'price': product.price,
                  'quantity': product.quantity,
                })
            .toList(),
        'dateTime': DateTime.now().toIso8601String(),
        'userId': userId,
      });
      _orders.insert(
        0,
        OrderItem(
          id: insertedOrder.id,
          amount: totalPrice,
          products: cartItem,
          customerName: customerName,
          deliveryAddress: deliveryAddress,
          dateTime: DateTime.now(),
        ),
      );
    } catch (_) {
      rethrow;
    }

    notifyListeners();
  }
}
