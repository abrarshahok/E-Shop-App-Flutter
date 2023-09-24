import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AllProductsLoadingScreen extends StatelessWidget {
  const AllProductsLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: 6,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
