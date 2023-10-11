import 'package:flutter/material.dart';

Widget notFound(String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/not-found.png',
              fit: BoxFit.contain,
              height: 300,
            ),
          ),
        ),
      ),
      const SizedBox(height: 50),
      Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
    ],
  );
}

AppBar appBar(String title, {bool center = false}) {
  return AppBar(
    elevation: 0,
    centerTitle: center,
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

const String requiredField = 'This field is required';
