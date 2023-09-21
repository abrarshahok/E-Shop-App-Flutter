import 'package:firebase_auth/firebase_auth.dart';

import '/models/cart_item.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};
  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get itemsCount => _cartItems.length;

  double get total {
    double total = 0.0;
    _cartItems.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  Future<void> fetchCartItems() async {
    try {
      final cartDocs =
          await FirebaseFirestore.instance.collection('cart').get();
      final cartInfo = cartDocs.docs;
      cartInfo
          .map((product) => _cartItems.putIfAbsent(
                product.id,
                () => CartItem(
                  id: product['id'],
                  title: product['title'],
                  image: product['image'],
                  price: product['price'],
                  quantity: product['quantity'],
                ),
              ))
          .toList();
    } catch (_) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> addItem({
    required String productId,
    required String title,
    required String imageUrl,
    required double price,
  }) async {
    final firebaseDB = FirebaseFirestore.instance;
    try {
      if (_cartItems.containsKey(productId)) {
        _cartItems.update(
          productId,
          (item) => CartItem(
            id: item.id,
            title: item.title,
            image: item.image,
            price: item.price,
            quantity: item.quantity + 1,
          ),
        );
        final currentItem = _cartItems[productId];
        await firebaseDB.collection('cart').doc(productId).set({
          'id': currentItem!.id,
          'title': title,
          'image': imageUrl,
          'price': price,
          'quantity': currentItem.quantity,
        });
      } else {
        await firebaseDB.collection('cart').doc(productId).set({
          'id': DateTime.now().toString(),
          'title': title,
          'image': imageUrl,
          'price': price,
          'quantity': 1,
        });
        _cartItems.putIfAbsent(
          productId,
          () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            image: imageUrl,
            price: price,
            quantity: 1,
          ),
        );
      }
    } catch (_) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeItem({required String productId}) async {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    final firebaseDB = FirebaseFirestore.instance;
    final currentItem = _cartItems[productId];
    try {
      if (_cartItems[productId]!.quantity > 1) {
        _cartItems.update(
          productId,
          (item) => CartItem(
            id: item.id,
            title: item.title,
            image: item.image,
            price: item.price,
            quantity: item.quantity - 1,
          ),
        );
        await firebaseDB.collection('cart').doc(currentItem!.id).set({
          'title': currentItem.title,
          'image': currentItem.image,
          'price': currentItem.price,
          'quantity': currentItem.quantity,
        });
      } else {
        await firebaseDB.collection('cart').doc(currentItem!.id).delete();
        _cartItems.remove(productId);
      }
    } catch (_) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> deleteItemFromCart(String productId) async {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    final firebaseDB = FirebaseFirestore.instance;
    final currentItem = _cartItems[productId];
    try {
      await firebaseDB.collection('cart').doc(currentItem!.id).delete();
      _cartItems.remove(productId);
    } catch (_) {
      _cartItems[productId] = currentItem!;
      rethrow;
    }
    notifyListeners();
  }

  void clearCart() async {
    try {
      await FirebaseFirestore.instance.collection('cart').get().then((snapsot) {
        for (DocumentSnapshot snap in snapsot.docs) {
          snap.reference.delete();
        }
      });
      _cartItems.clear();
    } catch (_) {
      rethrow;
    }
    notifyListeners();
  }
}
