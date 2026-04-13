import 'package:mytasks/features/cart/domain/entity/cart_item_entity.dart';
import 'package:mytasks/features/products/domain/entities/productEntity.dart';

abstract class CartRepository {
  List<CartItemEntity> getCartItems();
  void addToCart(ProductEntity product);
  void removeFromCart(ProductEntity product);
  void clearCart();
  double getTotalPrice();
}