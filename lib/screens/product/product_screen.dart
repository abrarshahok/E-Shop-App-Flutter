import '/widgets/product/product_items.dart';
import '/models/product.dart';
import '/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = '/products-screen';

  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String title = product['title'];
    final Categories category = product['category'];
    final categoryProducts =
        Provider.of<ProductProvider>(context, listen: false)
            .getCategoryProducts(category);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categoryProducts.length,
        itemBuilder: (ctx, index) => ProductItems(
          id: categoryProducts[index].id,
          title: categoryProducts[index].title,
          description: categoryProducts[index].description,
          image: categoryProducts[index].image,
          price: categoryProducts[index].price,
          stock: categoryProducts[index].stock,
        ),
      ),
    );
  }
}
