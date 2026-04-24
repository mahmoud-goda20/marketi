import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/falier.dart';
import 'package:marketi/feature/favorite/domain/entity/favorite_entity.dart';

abstract class FavoriteRepo {
  Future<void> addToFavorite(String productId);

  Future<void> removeFromFavorite(String productId);

  Future<Either<Failer, FavoriteEntity>> getFavorite();
}