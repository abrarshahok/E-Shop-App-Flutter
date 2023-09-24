import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String? _userName;
  String get userName => _userName == null ? 'Unknown' : _userName!;

  Future<void> submitUserInfo({
    required String email,
    required String username,
    required String password,
    required bool isLogin,
  }) async {
    UserCredential userCredential;
    final auth = FirebaseAuth.instance;
    try {
      if (isLogin) {
        userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': username,
          'email': email,
          'role': 'user',
        });
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> isAdmin(String userID) async {
    final firebaseDB =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    _userName = firebaseDB['username'];
    if (firebaseDB['role'] == 'admin') {
      return true;
    }
    return false;
  }
}
