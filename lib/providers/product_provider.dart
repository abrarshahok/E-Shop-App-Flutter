import '/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      title: 'Iphone 15 Pro Max',
      description:
          'This is the latest iPhone product, a culmination of cutting-edge technology and sleek design that continues to redefine the boundaries of innovation in the smartphone industry. With each new release, Apple consistently raises the bar, and this latest iPhone is no exception.',
      image:
          'https://sparkimg.nl/cdn-cgi/image/w=480,h=320,fit=pad,f=auto/https://static.iphoned.nl/orca/products/20170/apple-iphone-15-pro-max.png',
      stock: 5,
      price: 1500.0,
      category: Categories.iphone,
    ),
    Product(
      id: '2',
      title: 'MacBook Pro',
      description:
          "This is the Latest MacBook, a pinnacle of innovation and design in the world of computing. With each new release, Apple continues to push the boundaries of what a laptop can do, setting the standard for performance, aesthetics, and user experience.",
      image:
          'https://cdn.thewirecutter.com/wp-content/media/2023/01/macbookpro-2048px-0173.jpg',
      stock: 5,
      price: 1300.0,
      category: Categories.macbook,
    ),
    Product(
      id: '3',
      title: 'Vivo S1',
      description:
          'This is the Latest Android Phone, a cutting-edge marvel that represents the pinnacle of innovation and functionality in the world of mobile devices. With each new release, Android phones continue to push the boundaries of what smartphones can do, setting the standard for performance, features, and user experience.',
      image:
          'https://in-exstatic-vivofs.vivo.com/gdHFRinHEMrj3yPG/1564573951724/54b4e694bb30be120f27f3fa9d8032a1.jpg',
      stock: 5,
      price: 150.0,
      category: Categories.android,
    ),
    Product(
      id: '4',
      title: 'Core i9 12th Generation',
      description:
          'This is the Latest Generation Laptop, a remarkable leap forward in the world of computing technology. With each new generation, laptops become more powerful, versatile, and efficient, offering users an unparalleled computing experience.',
      image:
          'https://i5.walmartimages.com/asr/e816526d-ea52-4605-a2c6-5d967e02debf.935fb382583f1560dcd139a88cfa1d73.jpeg',
      stock: 5,
      price: 1000.0,
      category: Categories.laptop,
    ),
  ];

  List<Product> get products {
    return [..._products];
  }

  List<Product> getCategoryProducts(Categories category) {
    return _products.where((product) => product.category == category).toList();
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  void minusStock({required String id, required int quantity}) {
    final product = _products.firstWhere((product) => product.id == id);
    final index = _products.indexWhere((product) => product.id == id);
    _products[index] = Product(
      id: product.id,
      title: product.title,
      description: product.description,
      image: product.image,
      stock: product.stock - quantity,
      price: product.price,
      category: product.category,
    );
    notifyListeners();
  }
}
