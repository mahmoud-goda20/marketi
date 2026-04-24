import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/falier.dart';
import 'package:marketi/feature/cart/domain/entity/cart_entity.dart';

abstract class CartRepo {
  Future<void> addToCart(String productId);

  Future<void> removeFromCart(String productId);

  Future<Either<Failer, CartEntity>> getCart();
}