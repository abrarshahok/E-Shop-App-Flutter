import 'package:eshop_flutter_app/models/product.dart';
import 'package:eshop_flutter_app/widgets/product/product_categories.dart';
import 'package:flutter/material.dart';

class ProductCategoriesScreen extends StatelessWidget {
  const ProductCategoriesScreen({super.key});
  final List<Map<String, dynamic>> _categories = const [
    {
      'title': 'IPhones',
      'image': 'assets/images/iphone.png',
      'category': Categories.iphone,
    },
    {
      'title': 'MacBooks',
      'image': 'assets/images/macbook.jpg',
      'category': Categories.macbook,
    },
    {
      'title': 'Laptops',
      'image': 'assets/images/laptop.jpeg',
      'category': Categories.laptop,
    },
    {
      'title': 'Android Phones',
      'image': 'assets/images/android.jpg',
      'category': Categories.android,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _categories.length,
      itemBuilder: (ctx, index) => ProductCategoriesItems(
        title: _categories[index]['title'],
        image: _categories[index]['image'],
        category: _categories[index]['category'],
      ),
    );
  }
}
