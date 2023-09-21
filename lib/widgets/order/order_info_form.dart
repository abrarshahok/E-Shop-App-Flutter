import 'package:flutter/material.dart';

class OrderInfoForm extends StatelessWidget {
  OrderInfoForm({
    required this.submit,
    required this.isLoading,
  });
  final bool isLoading;
  final void Function({
    required String firstName,
    required String lastName,
    required String address,
  }) submit;

  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _firstName;
  String? _lastName;
  String? _address;
  void _confirmOrder(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      submit(
        firstName: _firstName!.trim(),
        lastName: _lastName!.trim(),
        address: _address!.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: '*First Name'),
                  onSaved: (name) => _firstName = name,
                  validator: (name) {
                    if (name!.trim().isEmpty || name.length < 3) {
                      return 'Please enter valid name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  onSaved: (lastName) => _lastName = lastName,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: '*Delivery Adrress'),
                  onSaved: (address) => _address = address,
                  validator: (address) {
                    if (address!.trim().isEmpty || address.length < 5) {
                      return 'Please enter valid Address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => _confirmOrder(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                        ),
                        child: const Text(
                          'Cofirm Order',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
