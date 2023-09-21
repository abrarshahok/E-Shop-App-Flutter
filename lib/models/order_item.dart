import 'cart_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final String customerName;
  final String deliveryAddress;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.customerName,
    required this.deliveryAddress,
    required this.dateTime,
  });
}
