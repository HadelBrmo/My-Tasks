import 'package:equatable/equatable.dart';
import 'package:mytasks/features/products/domain/entities/productEntity.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final ProductEntity product;
  const AddToCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final ProductEntity product;
  const RemoveFromCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}