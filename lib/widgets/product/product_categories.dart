import 'package:eshop_flutter_app/screens/product/product_screen.dart';

import '/models/product.dart';
import 'package:flutter/material.dart';

class ProductCategoriesItems extends StatelessWidget {
  const ProductCategoriesItems({super.key, 
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
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      shadowColor: Colors.black,
      child: GridTile(
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Colors.black54,
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
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
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
