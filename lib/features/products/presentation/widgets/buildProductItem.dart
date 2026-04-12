import 'package:flutter/material.dart';
import 'package:mytasks/core/utils/app_colors/app_colors.dart';
import 'package:mytasks/features/products/domain/entities/productEntity.dart';

class ProductItem extends StatelessWidget {
  final ProductEntity product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color blackColor = Colors.black;

    return GestureDetector(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 6,
                offset: const Offset(0, 3),
                color: blackColor.withOpacity(0.05),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Row(
                children: [
                  Expanded(
    flex: 3,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        product.image,
        height: 100,
        fit: BoxFit.cover,
     
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
       
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
      ),
    ),
  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Price: ${product.price}\$",
                          style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Discount: ${product.discount}%",
                          style: const TextStyle(fontSize: 14, color: Colors.red),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              "${product.rating}",
                              style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                 
      
                ],
              ),
              
              Positioned(
                bottom: -5,
                right: -5,
                child: CircleAvatar(
                  backgroundColor: AppColors.black,
                  child: IconButton(
                    icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                    onPressed: () {
                      
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}