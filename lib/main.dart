import 'package:eshop_flutter_app/screens/app/homepage.dart';

import '/screens/order/order_info_screen.dart';
import '/providers/auth_provider.dart';
import '/screens/auth/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '/providers/order_item_provider.dart';
import '/screens/cart/add_to_cart_screen.dart';
import '/providers/cart_item_provider.dart';
import 'screens/product/product_screen.dart';
import '/providers/product_provider.dart';
import '/screens/product/product_detail_screen.dart';
import 'screens/app/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.grey,
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, streamSnapshot) {
            if (streamSnapshot.hasData) {
              return const HomePage();
            } else {
              return const AuthScreen();
            }
          },
        ),
        routes: {
          ProductScreen.routeName: (context) => const ProductScreen(),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          AddToCartScreen.routeName: (context) => const AddToCartScreen(),
          OrderInfoScreen.routeName: (context) => const OrderInfoScreen(),
        },
      ),
    );
  }
}
