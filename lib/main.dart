import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytasks/core/services/service_locator.dart';
import 'package:mytasks/features/cart/presentation/bloc/cart%20bloc.dart';
import 'package:mytasks/features/products/presentation/bloc/product_bloc.dart';
import 'package:mytasks/features/splash/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CartBloc>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}