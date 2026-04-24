import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/falier.dart';
import 'package:marketi/feature/home/domain/entitiy/brand_entity.dart';
import 'package:marketi/feature/home/domain/entitiy/category_entity.dart';
import 'package:marketi/feature/home/domain/entitiy/products_entity.dart';

abstract class HomeRepo {
  Future<Either<Failer, ProductsEntity>> getProducts({
    int limit = 10,
    int skip = 0,
  });

  Future<Either<Failer, ProductsEntity>> searchProducts(String search,{int skip=0,int limit=5});

  Future<Either<Failer, ProductsEntity>> getProductsByCategory(String category);
  
  Future<Either<Failer, ProductsEntity>> getProductsByBrand(String brand);

  Future<Either<Failer, ProductEntity>> getProductDetails(int id);

  Future<Either<Failer, CategoriesEntity>> getCategories();

  Future<Either<Failer, BrandsEntity>> getBrands();

  
}
