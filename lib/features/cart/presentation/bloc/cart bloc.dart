import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytasks/features/cart/domain/entity/cart_item_entity.dart';
import 'package:mytasks/features/cart/presentation/bloc/CartState.dart';
import 'package:mytasks/features/cart/presentation/bloc/cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItemEntity> _cartItems = [];

  CartBloc() : super(CartInitial()) {

    on<AddToCartEvent>((event, emit) {
      final index = _cartItems.indexWhere((item) => item.product.id == event.product.id);

      if (index >= 0) {
        _cartItems[index] = _cartItems[index].copyWith(quantity: _cartItems[index].quantity + 1);
      } else {
        _cartItems.add(CartItemEntity(product: event.product, quantity: 1));
      }

      emit(CartUpdated(List.from(_cartItems)));
    });

    on<RemoveFromCartEvent>((event, emit) {
      _cartItems.removeWhere((item) => item.product.id == event.product.id);
      emit(CartUpdated(List.from(_cartItems)));
    });
  }
}