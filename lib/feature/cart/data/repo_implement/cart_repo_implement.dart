import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketi/core/errors/falier.dart';
import 'package:marketi/core/services/api/data_base_sevices.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';
import 'package:marketi/feature/cart/data/models/cart_model.dart';
import 'package:marketi/feature/cart/domain/entity/cart_entity.dart';
import 'package:marketi/feature/cart/domain/repo/cart_repo.dart';

class CartRepoImplement implements CartRepo {
  DataBaseServices dataBaseServices;
  CartRepoImplement(this.dataBaseServices);

  @override
  Future<void> addToCart(String productId) async {
    try {
      final token = PreferenceManager.instance.getString('token');
      await dataBaseServices.postData(
        path: '/user/addCart',
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
  Future<void> removeFromCart(String productId) async {
    try {
      final token = PreferenceManager.instance.getString('token');
      await dataBaseServices.deleteData(
        path: '/user/deleteCart',
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
  Future<Either<Failer, CartEntity>> getCart() async {
    try {
      final token = PreferenceManager.instance.getString('token');
      final response = await dataBaseServices.getData(
        path: '/user/getCart',
        token: token,
      );
      final cartResponse = CartResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Right(cartResponse.toEntity());
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return Left(Failer(errorMessage: e.toString()));
    }
  }
}
