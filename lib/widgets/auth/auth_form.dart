import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function({
    required String email,
    required String username,
    required String password,
    required bool isLogin,
  }) submit;
  final bool isLoading;
  const AuthForm({super.key, required this.submit, required this.isLoading});
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String? _userEmail;
  String? _userName;
  String? _userPassword;
  bool _isLogin = true;

  void _submitUserData() {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submit(
        email: _userEmail!.trim(),
        username: !_isLogin ? _userName!.trim() : '',
        password: _userPassword!.trim(),
        isLogin: _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter valid email address.';
                      }
                      return null;
                    },
                    onSaved: (email) => _userEmail = email,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                      onSaved: (username) => _userName = username,
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    onSaved: (password) => _userPassword = password,
                  ),
                  const SizedBox(height: 10),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _submitUserData,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  TextButton(
                    onPressed: () {
                      setState(() => _isLogin = !_isLogin);
                    },
                    child: Text(
                      _isLogin
                          ? 'Create new account'
                          : 'I already have an accoount!',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
