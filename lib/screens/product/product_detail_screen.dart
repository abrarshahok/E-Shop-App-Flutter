import 'package:eshop_flutter_app/constants/constants.dart';
import 'package:line_icons/line_icons.dart';
import '/providers/cart_item_provider.dart';
import '/providers/product_provider.dart';
import '/screens/cart/add_to_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail-screen';
  final draggableScrollableController = DraggableScrollableController();

  ProductDetailScreen({super.key});
  BorderRadiusGeometry get borderRadius {
    return const BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
    );
  }

  Widget myCustomButton({
    required String label,
    required IconData icon,
    required Function() onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 5,
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget customRow({
    required double width,
    required String label,
    required String item,
    required Widget sizedBox,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        sizedBox,
        Container(
          height: 25,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(item),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);

    void startAddingItemToCart() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (context) => const AddToCartScreen(),
        routeSettings: RouteSettings(arguments: productId),
      ).then((value) {
        if (value == true) {
          return;
        } else {
          Provider.of<CartItemProvider>(
            context,
            listen: false,
          ).deleteItemFromCart(productId);
        }
      });
    }

    return Scaffold(
      appBar: appBar('Product Overview'),
      body: Stack(
        children: [
          Hero(
            tag: product.id,
            child: Container(
              height: 400,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: DraggableScrollableSheet(
              controller: draggableScrollableController,
              initialChildSize: 0.45,
              maxChildSize: 1.0,
              minChildSize: 0.3,
              builder: (context, scrollController) => ListView(
                controller: scrollController,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: double.infinity,
                    height: 800,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[800]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 20),
                        customRow(
                          width: 100,
                          label: 'Price',
                          item: '\$${product.price}',
                          sizedBox: const SizedBox(width: 14),
                        ),
                        const SizedBox(height: 20),
                        customRow(
                          width: 150,
                          label: 'Stock',
                          item: '${product.stock} item(s) available',
                          sizedBox: const SizedBox(width: 10),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.description,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            myCustomButton(
              icon: LineIcons.heart,
              label: 'Add to Favourite',
              onPressed: () {},
            ),
            myCustomButton(
              icon: LineIcons.shoppingCart,
              label: 'Add to Cart',
              onPressed: startAddingItemToCart,
            ),
          ],
        ),
      ),
    );
  }
}
