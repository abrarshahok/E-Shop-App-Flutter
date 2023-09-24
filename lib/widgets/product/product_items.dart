import '/screens/product/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductItems extends StatelessWidget {
  const ProductItems({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.stock,
  });
  final String id;
  final String title;
  final String description;
  final String image;
  final double price;
  final int stock;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      shadowColor: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: id,
                child: Image.network(
                  image,
                  fit: BoxFit.contain,
                  height: 120,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 20,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Text(
                  'Free Delivery',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          onTap: () => Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: id,
          ),
        ),
      ),
    );
  }
}
