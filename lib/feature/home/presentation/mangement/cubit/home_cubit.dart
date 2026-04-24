import 'package:bloc/bloc.dart';
import 'package:marketi/feature/home/domain/entitiy/brand_entity.dart';
import 'package:marketi/feature/home/domain/entitiy/category_entity.dart';
import 'package:marketi/feature/home/domain/entitiy/products_entity.dart';
import 'package:marketi/feature/home/domain/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  final HomeRepo homeRepo;

  List<ProductEntity> products = [];
  List<CategoryEntity> categories = [];
  List<BrandEntity> brands = [];

  void getProducts() async {
    emit(HomeLoading());

    final result = await homeRepo.getProducts();

    result.fold(
      (failure) {
        emit(HomeFailure(errorMessage: failure.errorMessage));
      },
      (productsEntity) {
        products = productsEntity.list;
        emit(HomeSuccess(productsEntity: productsEntity));
      },
    );
  }

  void getCategories() async {
    emit(HomeLoading());

    final result = await homeRepo.getCategories();

    result.fold(
      (failure) {
        emit(HomeFailure(errorMessage: failure.errorMessage));
      },
      (categoriesEntity) {
        categories = categoriesEntity.list;
        emit(HomeSuccess(categoriesEntity: categoriesEntity));
      },
    );
  }

  void getBrands() async {
    emit(HomeLoading());

    final result = await homeRepo.getBrands();

    result.fold(
      (failure) {
        emit(HomeFailure(errorMessage: failure.errorMessage));
      },
      (brandsEntity) {
        brands = brandsEntity.list;
        emit(HomeSuccess(brandsEntity: brandsEntity));
      },
    );
  }

  void searchProducts(String search) async {
    emit(HomeLoading());
    final result = await homeRepo.searchProducts(search);
    result.fold(
      (failure) {
        emit(HomeFailure(errorMessage: failure.errorMessage));
      },
      (productsEntity) {
        products = productsEntity.list;
        emit(HomeSuccess(productsEntity: productsEntity));
      },
    );
  }
}
