import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};
  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get itemsCount => _cartItems.length;
  String get userId => FirebaseAuth.instance.currentUser!.uid;

  double get total {
    double total = 0.0;
    _cartItems.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  Future<void> fetchCartItems() async {
    try {
      final cartRefs = await FirebaseFirestore.instance
          .collection('cart')
          .doc(userId)
          .collection(userId)
          .get();
      final cartInfo = cartRefs.docs;
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
    final cartRefs = FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection(userId)
        .doc(productId);
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
        await cartRefs.set({
          'id': currentItem!.id,
          'title': title,
          'image': imageUrl,
          'price': price,
          'quantity': currentItem.quantity,
        });
      } else {
        await cartRefs.set({
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
    final cartRefs = FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection(userId)
        .doc(productId);
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
        await cartRefs.set({
          'id': currentItem!.id,
          'title': currentItem.title,
          'image': currentItem.image,
          'price': currentItem.price,
          'quantity': currentItem.quantity,
        });
      } else {
        await cartRefs.delete();
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

    final cartRefs = FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection(userId)
        .doc(productId);
    final currentItem = _cartItems[productId];
    try {
      await cartRefs.delete();
      _cartItems.remove(productId);
    } catch (_) {
      _cartItems[productId] = currentItem!;
      rethrow;
    }
    notifyListeners();
  }

  void clearCart() async {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(userId)
          .collection(userId)
          .get()
          .then((snapsot) {
        for (DocumentSnapshot snap in snapsot.docs) {
          final quantity = _cartItems[snap.id]!.quantity;
          _minusStock(snap.id, quantity);
          snap.reference.delete();
        }
      }).whenComplete(() => _cartItems.clear());
    } catch (_) {
      rethrow;
    }
    notifyListeners();
  }

  void _minusStock(String id, int quantity) async {
    final currentProductRefs =
        FirebaseFirestore.instance.collection('products').doc(id);
    final currentProductInfo = await currentProductRefs.get();
    await currentProductRefs.set({
      'category': currentProductInfo['category'],
      'title': currentProductInfo['title'],
      'description': currentProductInfo['description'],
      'image': currentProductInfo['image'],
      'stock': int.parse(currentProductInfo['stock'].toString()) - quantity,
      'price': double.parse(currentProductInfo['price'].toString()),
    });
    notifyListeners();
  }
}
