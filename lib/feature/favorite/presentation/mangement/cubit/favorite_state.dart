import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/falier.dart';
import 'package:marketi/feature/favorite/domain/entity/favorite_entity.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteFailure extends FavoriteState {
  final String errorMessage;
  FavoriteFailure({required this.errorMessage});
}

final class FavoriteSuccess extends FavoriteState {
  final Either<Failer, FavoriteEntity> favoriteEnttiy;
  FavoriteSuccess({required this.favoriteEnttiy});
}
