import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/falier.dart';
import 'package:marketi/feature/cart/domain/entity/cart_entity.dart';
import 'package:marketi/feature/cart/domain/repo/cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepo) : super(CartInitial());
  CartRepo cartRepo;
  List<CartItemEntity> products = [];

  void addToCart(String productId) async {
    emit(CartLoading());
    try {
      await cartRepo.addToCart(productId);
      final result = await cartRepo.getCart();
      result.fold(
        (failure) => emit(CartFailure(errorMessage: failure.errorMessage)),
        (cartEntity) {
          products = cartEntity.items;
          emit(CartSuccess(cartEntity: Right(cartEntity)));
        },
      );
    } catch (e) {
      emit(CartFailure(errorMessage: e.toString()));
    }
  }

  void removeFromCart(String productId) async {
    emit(CartLoading());
    try {
      await cartRepo.removeFromCart(productId);
      final result = await cartRepo.getCart();
      result.fold(
        (failure) => emit(CartFailure(errorMessage: failure.errorMessage)),
        (cartEntity) {
          products = cartEntity.items;
          emit(CartSuccess(cartEntity: Right(cartEntity)));
        },
      );
    } catch (e) {
      emit(CartFailure(errorMessage: e.toString()));
    }
  }

  void getCart() async {
    emit(CartLoading());
    final result = await cartRepo.getCart();
    result.fold(
      (failure) => emit(CartFailure(errorMessage: failure.errorMessage)),
      (cartEntity) {
        products = cartEntity.items;
        emit(CartSuccess(cartEntity: Right(cartEntity)));
      },
    );
  }

  void incrementQuantity(String productId) {
    products = products.map((item) {
      if (item.product.id.toString() == productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    emit(CartSuccess(cartEntity: Right(CartEntity(items: products))));
  }

  void decrementQuantity(String productId) {
    products = products.map((item) {
      if (item.product.id.toString() == productId) {
        if (item.quantity > 1) {
          return item.copyWith(quantity: item.quantity - 1);
        }
      }
      return item;
    }).toList();
    emit(CartSuccess(cartEntity: Right(CartEntity(items: products))));
  }
}
