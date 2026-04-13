import 'package:equatable/equatable.dart';
import 'package:mytasks/features/cart/domain/entity/cart_item_entity.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartItemEntity> cartItems;
  const CartUpdated(this.cartItems);

  @override
  List<Object?> get props => [cartItems];
}