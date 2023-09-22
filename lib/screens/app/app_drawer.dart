import 'package:eshop_flutter_app/providers/cart_item_provider.dart';
import '/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget cutomListTile({
    required BuildContext ctx,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      tileColor: Colors.grey[200],
      leading: Icon(
        icon,
        color: Colors.grey,
        size: 30,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAdmin = false;
    final userID = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder(
      future: Provider.of<AuthProvider>(context).isAdmin(userID),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          isAdmin = true;
        }
        final userName =
            Provider.of<AuthProvider>(context, listen: false).userName;
        return Drawer(
          child: snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome $userName',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (isAdmin) const Divider(),
                    if (isAdmin)
                      cutomListTile(
                        ctx: context,
                        title: 'Manage Products',
                        icon: Icons.edit,
                        onTap: () {},
                      ),
                    const Divider(),
                    cutomListTile(
                      ctx: context,
                      title: 'View All Products',
                      icon: Icons.shop,
                      onTap: () {},
                    ),
                    const Divider(),
                    cutomListTile(
                      ctx: context,
                      title: 'Logout',
                      icon: Icons.exit_to_app,
                      onTap: () => FirebaseAuth.instance.signOut(),
                    ),
                    const Divider(),
                  ],
                ),
        );
      },
    );
  }
}
