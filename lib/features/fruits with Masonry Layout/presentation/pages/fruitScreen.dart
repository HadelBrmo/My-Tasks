import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../data/models/fruits.dart';
import '../widgets/FruitCard.dart';

class FruitScreen extends StatelessWidget {
final List<Fruit> fruits = [
  Fruit(
    name: 'Apple',
    price: '\$5.4',
    image: 'assets/images/fruits/apple.png',
    backgroundColor: const Color(0xFFFFCDD2),
  ),
  Fruit(
    name: 'Banana',
    price: '\$3.2',
    image: 'assets/images/fruits/banana.png',
    backgroundColor: const Color(0xFFFFF9C4), 
  ),
  Fruit(
    name: 'Grapes',
    price: '\$6.5',
    image: 'assets/images/fruits/grapes.png',
    backgroundColor: const Color(0xFFE1BEE7),
  ),
  Fruit(
    name: 'Orange',
    price: '\$4.0',
    image: 'assets/images/fruits/orange.png',
    backgroundColor: const Color(0xFFFFE0B2), 
  ),
  Fruit(
    name: 'Berry',
    price: '\$7.2',
    image: 'assets/images/fruits/berry.png',
    backgroundColor: const Color(0xFFBBDEFB), 
  ),
  Fruit(
    name: 'Cherry',
    price: '\$8.5',
    image: 'assets/images/fruits/cherry.png',
    backgroundColor: const Color(0xFFF48FB1),
  ),
  Fruit(
    name: 'Pineapple',
    price: '\$9.0',
    image: 'assets/images/fruits/pineapple.png',
    backgroundColor: const Color(0xFFFFF59D), 
  ),
  Fruit(
    name: 'Strawberry',
    price: '\$9.0',
    image: 'assets/images/fruits/strawberry.png',
    backgroundColor: const Color(0xFFFFAB91), 
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fruits and berries"), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: fruits.length,
          itemBuilder: (context, index) {
            return FruitCard(fruit: fruits[index]);
          },
        ),
      ),
    );
  }
}