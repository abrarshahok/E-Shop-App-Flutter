import '/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  void _submitAuthForm({
    required String email,
    required String username,
    required String password,
    required bool isLogin,
  }) async {
    try {
      setState(() => _isLoading = true);
      await Provider.of<AuthProvider>(context, listen: false).submitUserInfo(
        email: email,
        username: username,
        password: password,
        isLogin: isLogin,
      );
    } catch (_) {
      setState(() => _isLoading = false);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(
        submit: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
