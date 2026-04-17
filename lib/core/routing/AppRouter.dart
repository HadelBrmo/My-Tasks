import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytasks/core/services/service_locator.dart';
import 'package:mytasks/features/cart/presentation/bloc/cart%20bloc.dart';
import 'package:mytasks/features/cart/presentation/pages/cart%20page.dart';
import 'package:mytasks/features/products/presentation/bloc/product_bloc.dart';
import 'package:mytasks/features/products/presentation/pages/products_screen.dart';
import 'package:mytasks/features/splash/presentation/pages/splash_screen.dart';

class AppRouter {
  final CartBloc _cartBloc = sl<CartBloc>();

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
    case '/products':
  return MaterialPageRoute(
    builder: (context) => const ProductsScreen(),
  );
    case '/cart':
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: _cartBloc,
          child: const CartScreen(),
        ),
      );
    default:
      return null;
  }
}
}