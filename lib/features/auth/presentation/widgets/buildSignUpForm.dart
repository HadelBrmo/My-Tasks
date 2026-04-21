import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytasks/features/products/presentation/pages/products_screen.dart';

import 'buildSocialIconFromAsset.dart';

Widget buildSignUpForm(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      children: [

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
        SizedBox(height: 40),
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
        SizedBox(height: 30),
        Text(
          "____________________OR_____________________",
          style: TextStyle(color: Colors.black, fontSize: 17,fontWeight: FontWeight.bold,),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSocialIconFromAsset(
              assetPath: 'assets/icons/facebook.png',
              onTap: () {
              },
            ),
            SizedBox(width: 30),

            buildSocialIconFromAsset(
              assetPath: 'assets/icons/google-plus.png',
              onTap: () {
              },
            ),

            SizedBox(width: 30),
            buildSocialIconFromAsset(
              assetPath: 'assets/icons/twitter.png',
              onTap: () {
              },
            ),
          ],
        ),

        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: TextStyle(color: Colors.grey[600]),
            ),
            GestureDetector(
              onTap: () {
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),
      ],
    ),
  );
}

