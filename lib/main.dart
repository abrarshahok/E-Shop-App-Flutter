import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/screens/app/homepage.dart';
import 'screens/order/add_order_info_screen.dart';
import '/providers/auth_provider.dart';
import '/screens/auth/auth_screen.dart';
import 'providers/order_provider.dart';
import '/screens/cart/add_to_cart_screen.dart';
import 'providers/cart_provider.dart';
import 'screens/product/product_screen.dart';
import '/providers/product_provider.dart';
import '/screens/product/product_detail_screen.dart';

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
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderProvider(),
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
          textTheme: TextTheme(
            titleLarge: GoogleFonts.quicksand(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            labelLarge: GoogleFonts.quicksand(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: GoogleFonts.quicksand(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            bodySmall: GoogleFonts.quicksand(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
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
          AddOrderInfoScreen.routeName: (context) => const AddOrderInfoScreen(),
        },
      ),
    );
  }
}
