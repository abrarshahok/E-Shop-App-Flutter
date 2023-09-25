import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/order_item.dart';

class OrderItems extends StatefulWidget {
  final OrderItem order;
  const OrderItems({super.key, required this.order});

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final products = widget.order.products;
    String formatedDateTime =
        'Purchased on ${DateFormat('dd/MM/yyy').format(widget.order.dateTime)} at ${DateFormat('hh:mm a').format(widget.order.dateTime)}';
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              '\$${widget.order.amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              formatedDateTime,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            SizedBox(
              height: products.length * 80,
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (ctx, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[50],
                    radius: 30,
                    child: Image.network(
                      products[index].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: Text(products[index].title),
                  subtitle: Text(
                    'Purchased ${products[index].quantity} item(s)',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
