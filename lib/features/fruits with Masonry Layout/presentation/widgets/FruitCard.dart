import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/fruits.dart';

class FruitCard extends StatelessWidget {
  final Fruit fruit;
  const FruitCard({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: fruit.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fruit.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text("1kg\n${fruit.price}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 10),
          Center(child: Image.asset(fruit.image, height: 100)),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.add, size: 20),
            ),
          )
        ],
      ),
    );
  }
}