part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartFailure extends CartState {
  final String errorMessage;
  CartFailure({required this.errorMessage});
}

final class CartSuccess extends CartState {
  final Either<Failer, CartEntity> cartEntity;
  CartSuccess({required this.cartEntity});
}
