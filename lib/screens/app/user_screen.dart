import 'package:eshop_flutter_app/constants/constants.dart';

import '/screens/app/app_drawer.dart';
import '../cart/cart_screen.dart';
import '../order/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '/screens/product/product_screen.dart';
import '../product/product_categories_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
      'page': const OrdersScreen(),
    },
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        _screens[currentIndex]['title'] as String,
        center: true,
      ),
      drawer: const AppDrawer(),
      body: _screens[currentIndex]['page'] as Widget,
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
