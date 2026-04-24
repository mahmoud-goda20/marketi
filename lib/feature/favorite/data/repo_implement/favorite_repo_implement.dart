import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketi/core/errors/falier.dart';
import 'package:marketi/core/services/api/data_base_sevices.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';
import 'package:marketi/feature/favorite/data/models/favorite_model.dart';
import 'package:marketi/feature/favorite/domain/entity/favorite_entity.dart';
import 'package:marketi/feature/favorite/domain/repo/favorite_repo.dart';

class FavoriteRepoImplement implements FavoriteRepo {
  DataBaseServices dataBaseServices;
  FavoriteRepoImplement(this.dataBaseServices);

  @override
  Future<void> addToFavorite(String productId) async {
    try {
      final token = PreferenceManager.instance.getString('token');
      await dataBaseServices.postData(
        path: '/user/addFavorite',
        data: {'productId': productId},
        token: token,
      );
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e) {
      throw Failer(errorMessage: e.toString());
    }
  }

  @override
  Future<void> removeFromFavorite(String productId) async {
    try {
      final token = PreferenceManager.instance.getString('token');
      await dataBaseServices.deleteData(
        path: '/user/deleteFavorite',
        data: {'productId': productId},
        token: token,
      );
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e) {
      throw Failer(errorMessage: e.toString());
    }
  }

  @override
  Future<Either<Failer, FavoriteEntity>> getFavorite() async {
    try {
      final token = PreferenceManager.instance.getString('token');
      final response = await dataBaseServices.getData(
        path: '/user/getFavorite',
        token: token,
      );
      final favoriteResponse = FavoriteResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Right(favoriteResponse.toEntity());
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return Left(Failer(errorMessage: e.toString()));
    }
  }
}
