import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '/constants/constants.dart';
import '/providers/product_provider.dart';
import '/screens/app/app_drawer.dart';
import '../cart/cart_screen.dart';
import '../order/user_orders_screen.dart';
import '/screens/product/product_screen.dart';
import '../product/product_categories_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<UserScreen> {
  final _screens = [
    {
      'title': 'EShop',
      'page': ProductCategoriesScreen(),
    },
    {
      'title': 'All Products',
      'page': const ProductScreen(showAllProducts: true),
    },
    {
      'title': 'Your Cart',
      'page': const CartScreen(),
    },
    {
      'title': 'Your Orders',
      'page': const UserOrdersScreen(),
    },
  ];

  int currentIndex = 0;

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        _screens[currentIndex]['title'] as String,
        center: true,
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<ProductProvider>(context, listen: false)
            .fetchProducts(),
        child: _screens[currentIndex]['page'] as Widget,
      ),
      bottomNavigationBar: GNav(
        onTabChange: (index) => setState(() => currentIndex = index),
        gap: 8,
        activeColor: Colors.white,
        color: Colors.grey[800],
        curve: Curves.easeIn,
        backgroundColor: Colors.white,
        tabBackgroundColor: Colors.grey[800]!,
        tabMargin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        tabs: const [
          GButton(
            icon: LineIcons.home,
            text: 'Home',
          ),
          GButton(
            icon: LineIcons.search,
            text: 'Search',
          ),
          GButton(
            icon: LineIcons.shoppingCart,
            text: 'Cart',
          ),
          GButton(
            icon: LineIcons.moneyBill,
            text: 'Orders',
          ),
        ],
      ),
    );
  }
}
