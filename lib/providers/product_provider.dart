import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  List<Product> getCategoryProducts(Categories category) {
    return _products.where((product) => product.category == category).toList();
  }

  Categories getItemCategory(String category) {
    if (category == 'iphone') {
      return Categories.iphone;
    }
    if (category == 'android') {
      return Categories.android;
    }
    if (category == 'laptop') {
      return Categories.laptop;
    }
    return Categories.macbook;
  }

  Future<void> fetchProducts() async {
    try {
      final productData =
          await FirebaseFirestore.instance.collection('products').get();
      final productDocs = productData.docs;
      final List<Product> loadedProducts = [];
      for (var item in productDocs) {
        final category = item['category'];
        Categories itemCategory = getItemCategory(category);
        loadedProducts.insert(
          0,
          Product(
            id: item.id,
            title: item['title'],
            description: item['description'],
            image: item['image'],
            stock: int.parse(item['stock']),
            price: double.parse(item['price']),
            category: itemCategory,
          ),
        );
      }
      _products = loadedProducts;
    } catch (err) {
      rethrow;
    }
    notifyListeners();
  }

  void searchProducts(String title) {
    final searchedProducts = _products
        .where((item) => item.title.toLowerCase().contains(
              title.toLowerCase(),
            ))
        .toList();
    _products = searchedProducts;
    notifyListeners();
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }
}
