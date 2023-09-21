enum Categories { laptop, macbook, android, iphone }

class Product {
  final String id;
  final String title;
  final String description;
  final int stock;
  final String image;
  final double price;
  final Categories category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.stock,
    required this.price,
    required this.category,
  });
}
