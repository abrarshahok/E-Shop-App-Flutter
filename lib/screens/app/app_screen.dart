import 'package:eshop_flutter_app/screens/app/app_drawer.dart';

import '../cart/cart_screen.dart';
import '../order/orders_screen.dart';
import '../product/product_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final _screens = [
    {
      'title': 'EShop',
      'page': const ProductCategoriesScreen(),
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          _screens[currentIndex]['title'] as String,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
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
