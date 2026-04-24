import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:marketi/feature/favorite/domain/entity/favorite_entity.dart';
import 'package:marketi/feature/favorite/domain/repo/favorite_repo.dart';
import 'package:marketi/feature/favorite/presentation/mangement/cubit/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.favoriteRepo) : super(FavoriteInitial());
  FavoriteRepo favoriteRepo;
  List<FavoriteItemEntity> products = [];

  void addToFavorite(String productId) async {
    emit(FavoriteLoading());
    try {
      await favoriteRepo.addToFavorite(productId);
      final result = await favoriteRepo.getFavorite();
      result.fold(
        (failure) => emit(FavoriteFailure(errorMessage: failure.errorMessage)),
        (favoriteEnttiy) {
          products = favoriteEnttiy.items;
          emit(FavoriteSuccess(favoriteEnttiy: Right(favoriteEnttiy)));
        },
      );
    } catch (e) {
      emit(FavoriteFailure(errorMessage: e.toString()));
    }
  }

  void removeFromFavorite(String productId) async {
    emit(FavoriteLoading());
    try {
      await favoriteRepo.removeFromFavorite(productId);
      final result = await favoriteRepo.getFavorite();
      result.fold(
        (failure) => emit(FavoriteFailure(errorMessage: failure.errorMessage)),
        (favoriteEntity) {
          products = favoriteEntity.items;
          emit(FavoriteSuccess(favoriteEnttiy: Right(favoriteEntity)));
        },
      );
    } catch (e) {
      emit(FavoriteFailure(errorMessage: e.toString()));
    }
  }

  void getFavorite() async {
    emit(FavoriteLoading());
    final result = await favoriteRepo.getFavorite();
    result.fold(
      (failure) => emit(FavoriteFailure(errorMessage: failure.errorMessage)),
      (favoriteEntity) {
        products = favoriteEntity.items;
        emit(FavoriteSuccess(favoriteEnttiy: Right(favoriteEntity)));
      },
    );
  }
}
