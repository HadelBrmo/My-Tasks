import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytasks/core/utils/app_colors/app_colors.dart';
import 'package:mytasks/features/products/presentation/bloc/product_bloc.dart';
import 'package:mytasks/features/products/presentation/bloc/product_event.dart';
import 'package:mytasks/features/products/presentation/bloc/product_state.dart';
import 'package:mytasks/features/products/presentation/widgets/buildProductItem.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text(
    "Products Explorer",
    style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
      ),
      elevation: 10,
      backgroundColor: AppColors.black,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(12),
    ),
      ),
      actions: [
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search, color: AppColors.white),
    ),
      ],
    ),
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is ProductLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductItem(product: state.products[index]);
              },
            );
          }
          else if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: const TextStyle(color: Colors.red)),
                  ElevatedButton(
                    onPressed: () => context.read<ProductBloc>().add(GetProductsEvent()),
                    child: const Text("Retry"),
                  )
                ],
              ),
            );
          }
          return const Center(child: Text("Start exploring products!"));
        },
      ),
    );
  }
}