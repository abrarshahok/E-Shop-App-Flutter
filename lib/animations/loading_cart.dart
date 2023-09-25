import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCart extends StatelessWidget {
  const LoadingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(20),
            elevation: 1,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 6,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const SizedBox(height: 80),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
