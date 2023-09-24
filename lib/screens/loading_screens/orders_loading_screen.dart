import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrdersLoadingScreen extends StatelessWidget {
  const OrdersLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: ListView.builder(
        itemCount: 8,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const SizedBox(height: 150),
          );
        },
      ),
    );
  }
}
