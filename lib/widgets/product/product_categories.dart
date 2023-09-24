import 'package:flutter/material.dart';
import '/screens/product/product_screen.dart';
import '/models/product.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({
    super.key,
    required this.title,
    required this.image,
    required this.category,
  });
  final String title;
  final String image;
  final Categories category;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      shadowColor: Colors.black,
      child: GridTile(
        footer: Container(
          height: 40,
          width: double.infinity,
          color: Colors.grey[800],
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: InkWell(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductScreen.routeName,
              arguments: {
                'title': title,
                'category': category,
              },
            );
          },
        ),
      ),
    );
  }
}
