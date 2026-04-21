import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../products/presentation/pages/products_screen.dart';

Widget buildSignInForm(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(height: 40),
        TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            labelText: "Full Name",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(),
            labelText: "Password", suffixIcon: Icon(Icons.visibility))),
        SizedBox(height: 20),
        CheckboxListTile(title: Text("Remember Me"), value: false, onChanged: (val) {}),
        SizedBox(height: 60),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: Size(double.infinity, 50)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  ProductsScreen()),
              );
            },
            child: Text("Sign In", style: TextStyle(color: Colors.white))
        ),
      ],
    ),
  );
}