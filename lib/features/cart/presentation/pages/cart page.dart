import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytasks/core/utils/app_colors/app_colors.dart';
import 'package:mytasks/features/cart/presentation/bloc/CartState.dart';
import 'package:mytasks/features/cart/presentation/bloc/cart%20bloc.dart';
import '../../../chat with socket/presentation/bloc/ChatBloc.dart';
import '../../../chat with socket/presentation/pages/chat_screen.dart';
import '../utils/pdf_generator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated && state.cartItems.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.product.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item.product.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("${item.product.price}\$"),
                          trailing: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "x${item.quantity}",
                              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),


          child: Column(
          children: [
          ElevatedButton.icon(
          onPressed: () => generateCartPdf(state.cartItems),
          icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
          label: const Text('Export as PDF'),
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          minimumSize: const Size(double.infinity, 50),
          ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
          onPressed: () {
              print("🚀 تم الضغط على زر الشات!");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => ChatBloc(),
                    child: const ChatScreen(orderId: 'order_555'),
                  ),
                ),
              );

          },
          icon: const Icon(Icons.chat, color: Colors.white),
          label: const Text('Chat with Owner'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
          minimumSize: const Size(double.infinity, 50),
          ),
          ),
          ],
          ),
                )

              ],
            );
          }

          return const Center(
            child: Text("السلة فارغة حالياً!", style: TextStyle(fontSize: 18, color: Colors.grey)),
          );
        },
      ),
    );
  }
}