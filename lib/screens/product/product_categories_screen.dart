import 'package:eshop_flutter_app/models/product.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/widgets/product/product_categories.dart';
import 'package:flutter/material.dart';

class ProductCategoriesScreen extends StatelessWidget {
  ProductCategoriesScreen({super.key});
  final _controller = PageController();
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
      'image': 'assets/images/laptop.png',
      'category': Categories.laptop,
    },
    {
      'title': 'Android Phones',
      'image': 'assets/images/android.jpeg',
      'category': Categories.android,
    },
  ];

  Widget myContainer(String imageLocation) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imageLocation,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: PageView(
            controller: _controller,
            children: [
              myContainer('assets/images/eshop1.jpg'),
              myContainer('assets/images/eshop2.jpg'),
              myContainer('assets/images/eshop3.jpg'),
            ],
          ),
        ),
        SmoothPageIndicator(
          controller: _controller,
          count: 3,
          effect: JumpingDotEffect(
            dotColor: Colors.grey[400]!,
            activeDotColor: Colors.grey[800]!,
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _categories.length,
            itemBuilder: (ctx, index) => ProductCategories(
              title: _categories[index]['title'],
              image: _categories[index]['image'],
              category: _categories[index]['category'],
            ),
          ),
        ),
      ],
    );
  }
}
