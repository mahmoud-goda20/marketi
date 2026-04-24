part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final ProductsEntity? productsEntity;
  final CategoriesEntity? categoriesEntity;
  final BrandsEntity? brandsEntity;

  HomeSuccess({this.productsEntity, this.categoriesEntity, this.brandsEntity});
}


final class HomeFailure extends HomeState {
  final String errorMessage;

  HomeFailure({required this.errorMessage});
}
