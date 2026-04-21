import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytasks/features/products/presentation/pages/products_screen.dart';

Widget buildSignUpForm(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(height: 40),
        TextField(decoration: InputDecoration(
          fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(),
            labelText: "Full Name")),
        SizedBox(height: 20),
        TextField(decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(),
            labelText: "Email")),
        SizedBox(height: 20),
        TextField(decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(),
            labelText: "Password", suffixIcon: Icon(Icons.visibility_off))),
        SizedBox(height: 20),
        TextField(decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(),
            labelText: "Confirm Password")),
        SizedBox(height: 60),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: Size(double.infinity, 50)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  ProductsScreen()),
              );
            },
            child: Text("Sign up", style: TextStyle(color: Colors.white))
        ),
      ],
    ),
  );
}