import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketi/core/errors/falier.dart';
import 'package:marketi/core/services/api/data_base_sevices.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';
import 'package:marketi/feature/home/data/models/brand_model.dart';
import 'package:marketi/feature/home/data/models/category_model.dart';
import 'package:marketi/feature/home/data/models/products_model.dart';
import 'package:marketi/feature/home/domain/entitiy/brand_entity.dart';
import 'package:marketi/feature/home/domain/entitiy/category_entity.dart';
import 'package:marketi/feature/home/domain/entitiy/products_entity.dart';
import 'package:marketi/feature/home/domain/repo/home_repo.dart';

class HomeRepoImplement extends HomeRepo {
  DataBaseServices dataBaseServices;
  HomeRepoImplement(this.dataBaseServices);

  @override
  Future<Either<Failer, ProductEntity>> getProductDetails(int id) async {
    try {
      final response = await dataBaseServices.getData(path: '/products/$id');
      final product = ProductModel.fromJson(response as Map<String, dynamic>);
      return Right(product.toEntity());
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return Left(Failer(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failer, ProductsEntity>> getProducts({
    int limit = 10,
    int skip = 0,
  }) async {
    try {
      final token = PreferenceManager.instance.getString('token');
      final response = await dataBaseServices.getData(
        path: '/home/products?skip=$skip&limit=$limit',
        token: token,
      );
      final productsResponse = ProductsResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Right(productsResponse.toEntity());
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return Left(Failer(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failer, ProductsEntity>> getProductsByBrand(
    String brand,
  ) async {
    try {
      final response = await dataBaseServices.getData(
        path: '/products/brand/${Uri.encodeComponent(brand)}',
      );
      final productsResponse = ProductsResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Right(productsResponse.toEntity());
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return Left(Failer(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failer, ProductsEntity>> getProductsByCategory(
    String category,
  ) async {
    try {
      final response = await dataBaseServices.getData(
        path: '/products/category/${Uri.encodeComponent(category)}',
      );
      final productsResponse = ProductsResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Right(productsResponse.toEntity());
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return Left(Failer(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failer, ProductsEntity>> searchProducts(
    String search, {
    int skip = 0,
    int limit = 5,
  }) async {
    try {
      final token = PreferenceManager.instance.getString('token');
      final response = await dataBaseServices.postData(
        path: '/home/productsFilter',
        data: {'search': search, 'skip': skip, 'limit': limit},
        token: token,
      );
      final productsResponse = ProductsResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Right(productsResponse.toEntity());
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return Left(Failer(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failer, CategoriesEntity>> getCategories() async {
    try {
      final token = PreferenceManager.instance.getString('token');
      final response = await dataBaseServices.getData(
        path: '/home/categories',
        token: token,
      );
      final categoriesResponse = CategoriesResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Right(categoriesResponse.toEntity());
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return Left(Failer(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failer, BrandsEntity>> getBrands() async {
    try {
      final token = PreferenceManager.instance.getString('token');
      final response = await dataBaseServices.getData(
        path: '/home/brands',
        token: token,
      );
      final brandsResponse = BrandsResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Right(brandsResponse.toEntity());
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return Left(Failer(errorMessage: e.toString()));
    }
  }
}
