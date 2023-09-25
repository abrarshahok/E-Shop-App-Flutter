import '../../animations/loading_homepage.dart';
import '/screens/app/user_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAdmin = false;
    final userID = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<AuthProvider>(context).isAdmin(userID),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const LoadingHomePage();
          }
          if (futureSnapshot.hasError) {
            return const Text('An error occurred.');
          }
          if (futureSnapshot.data == true) {
            isAdmin = true;
          }
          if (isAdmin) {}
          return const UserScreen();
        },
      ),
    );
  }
}
