import 'package:flutter/material.dart';

import '../../../splash/presentation/widgets/buildSignInForm.dart';
import '../../../splash/presentation/widgets/buildSignUpForm.dart';

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Stack(
          children: [
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Icon(Icons.monetization_on, size: 80, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    "Expenses Management",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 220,
              left: 0,
              right: 0,
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[600],

                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
                tabs: [
                  Tab(text: "SIGN UP"),
                  Tab(text: "SIGN IN"),
                ],
              ),
            ),

            Positioned(
              top: 260,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Expanded(
                      child: TabBarView(
                        children: [
                          buildSignUpForm(context),
                          buildSignInForm(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}