import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytasks/core/utils/app_colors/app_colors.dart';
import 'package:mytasks/core/widgets/getSearch.dart';
import 'package:mytasks/features/cart/domain/entity/cart_item_entity.dart';
import 'package:mytasks/features/cart/presentation/bloc/CartState.dart';
import 'package:mytasks/features/cart/presentation/bloc/cart%20bloc.dart';
import 'package:mytasks/features/cart/presentation/pages/cart%20page.dart';
import 'package:mytasks/features/map/presentation/pages/MapScreen.dart';
import 'package:mytasks/features/products/presentation/bloc/product_bloc.dart';
import 'package:mytasks/features/products/presentation/bloc/product_event.dart';
import 'package:mytasks/features/products/presentation/bloc/product_state.dart';
import 'package:mytasks/features/products/presentation/widgets/buildProductItem.dart';

import '../../../../core/network/socket_service.dart';
import '../../../chat with chatGPT/presentation/pages/chatgpt_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductsEvent());
  }




  late final List<Widget> _pages = [
    _buildHomeScreen(),
    MapScreen(),
     CartScreen(),
     ChatgptScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(_selectedIndex == 0 ? "All Products" : (_selectedIndex == 1 ? "Map Location" :(_selectedIndex == 2) ?  "Cart":"ChatGPT"),
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
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

  Padding(

    padding: const EdgeInsets.only(right: 16.0, top: 8.0),

    child: BlocBuilder<CartBloc, CartState>(

      builder: (context, state) {

        int count = 0;

        List<CartItemEntity> items = [];



        if (state is CartUpdated) {

          count = state.cartItems.length;

          items = state.cartItems;

        }



        return GestureDetector(

          onTap: () {

            if (items.isEmpty) {

              ScaffoldMessenger.of(context).showSnackBar(

                const SnackBar(content: Text("السلة فارغة حالياً")),

              );

            } else {

              Navigator.push( context,

               MaterialPageRoute(builder: (context) => const CartScreen()),

  );

            }

          },

          child: Stack(

            alignment: Alignment.center,

            children: [

              const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 28),

              if (count > 0)

                Positioned(

                  top: -3,

                  right: 0,

                  child: Container(

                    padding: const EdgeInsets.all(2),

                    decoration: BoxDecoration(

                      color: Colors.red,

                      borderRadius: BorderRadius.circular(10),

                      border: Border.all(color: Colors.black, width: 1.5),

                    ),

                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),

                    child: Text(

                      '$count',

                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),

                      textAlign: TextAlign.center,

                    ),

                  ),

                ),

            ],

          ),

        );

      },

    ),

  ),

],

    ),
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex], 

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            backgroundColor: AppColors.black,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.mark_chat_unread_rounded), label: 'chatgpt'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        const Getsearch(),
        Expanded(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.black));
              } else if (state is ProductLoaded) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ProductItem(product: state.products[index]);
                  },
                );
              } else if (state is ProductError) {
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
        ),
      ],
    );
  }
}
