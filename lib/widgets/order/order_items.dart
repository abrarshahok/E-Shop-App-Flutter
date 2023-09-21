import 'dart:math';
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _isExpanded
          ? min(widget.order.products.length * 20.0 + 150, 200)
          : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '\$${widget.order.amount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyy  hh:mm a').format(widget.order.dateTime),
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
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isExpanded
                    ? min(widget.order.products.length * 20.0 + 110, 200)
                    : 0,
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: widget.order.products.length,
                  itemBuilder: (ctx, index) {
                    final orderedProducts = widget.order.products;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderedProducts[index].title,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'x ${orderedProducts[index].quantity}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
