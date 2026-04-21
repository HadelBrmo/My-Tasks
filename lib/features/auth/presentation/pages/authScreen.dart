import 'package:flutter/material.dart';

import '../widgets/buildSignInForm.dart';
import '../widgets/buildSignUpForm.dart';

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Icon(Icons.monetization_on, size: 80, color: Colors.white),
                SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      "Expenses",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      "Management",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: 220,
            left: -13,
            right: -13,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              indicator: BoxDecoration(),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              tabs: [
                Tab(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _tabController.index == 0 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Sign UP",
                        style: TextStyle(
                          color: _tabController.index == 0 ? Colors.green : Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _tabController.index == 1 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Log IN",
                        style: TextStyle(
                          color: _tabController.index == 1 ? Colors.green : Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 260,
            bottom: 0,
            left: 3,
            right: 3,
            child: ClipPath(
              clipper: _AuthClipper(tabIndex: _tabController.index),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
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
          ),
        ],
      ),
    );
  }
}

class _AuthClipper extends CustomClipper<Path> {
  final int tabIndex;

  _AuthClipper({required this.tabIndex});

  @override
  Path getClip(Size size) {
    final path = Path();
    final double notchWidth = 60;
    final double notchHeight = 20;

    double notchCenterX;
    if (tabIndex == 0) {

      notchCenterX = size.width * 0.3;
    } else {
      notchCenterX = size.width * 0.7;
    }

    print("tabIndex: $tabIndex, notchCenterX: $notchCenterX");

    path.lineTo(notchCenterX - notchWidth / 2, 0);
    path.lineTo(notchCenterX, -notchHeight);
    path.lineTo(notchCenterX + notchWidth / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    if (oldClipper is _AuthClipper) {
      return oldClipper.tabIndex != tabIndex;
    }
    return true;
  }
}