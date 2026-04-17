import 'package:equatable/equatable.dart';


class ProductEntity extends Equatable{
  final int id;
  final String title;
  final double price;
  final double discount;
  final double rating;
  final String image;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.rating,
    required this.image,
  });

  @override
  List<Object?> get props => [id,image, title, price, discount, rating];
}