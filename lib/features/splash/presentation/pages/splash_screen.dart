import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mytasks/core/utils/app_colors/app_colors.dart';
import 'package:mytasks/features/products/presentation/pages/products_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProductsScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Lottie.asset(
                   'assets/animations/shopping girl.json',
                    repeat: true,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.3,
            ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Text.rich(TextSpan(children: [
            TextSpan(
                  text: "Welcome to  ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "shopping online",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
              )
              ),
         
               ],
        ),
      ),
    );
  }
}