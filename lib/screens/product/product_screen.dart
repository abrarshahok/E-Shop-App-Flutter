import '/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../animations/loading_products.dart';
import '/widgets/product/product_items.dart';
import '/providers/product_provider.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/products-screen';
  final bool showAllProducts;
  const ProductScreen({super.key, this.showAllProducts = false});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Future? _futureProducts;
  Future getFutureProducts() {
    return Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  void initState() {
    _futureProducts = getFutureProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final modalData = ModalRoute.of(context)?.settings.arguments;
    Map<String, dynamic> product;
    dynamic category;
    dynamic title;
    if (modalData != null) {
      product = modalData as Map<String, dynamic>;
      category = product['category'];
      title = product['title'];
    }
    final productData = Provider.of<ProductProvider>(context);
    final products = widget.showAllProducts
        ? productData.products
        : productData.getCategoryProducts(category);

    return Scaffold(
      appBar: !widget.showAllProducts ? appBar(title) : null,
      body: RefreshIndicator(
        onRefresh: () => Provider.of<ProductProvider>(context, listen: false)
            .fetchProducts(),
        child: Column(
          mainAxisAlignment: products.isEmpty
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            if (products.isNotEmpty)
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    constraints: const BoxConstraints(maxHeight: 50),
                  ),
                  onChanged: (value) {
                    bool isEmpty = value.trim().isEmpty;
                    if (isEmpty) {
                      productData.fetchProducts();
                      return;
                    }
                    productData.searchProducts(value.trim());
                  },
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ),
              ),
            if (products.isEmpty)
              notFound('Products not found!')
            else
              FutureBuilder(
                future: _futureProducts,
                builder: (ctx, futureSnapshot) {
                  if (futureSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Expanded(
                      child: LoadingProducts(),
                    );
                  }

                  return Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 2.6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: products.length,
                      itemBuilder: (ctx, index) => ProductItems(
                        id: products[index].id,
                        title: products[index].title,
                        description: products[index].description,
                        image: products[index].image,
                        price: products[index].price,
                        stock: products[index].stock,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
