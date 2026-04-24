import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:marketi/core/services/api/api_services.dart';
import 'package:marketi/feature/auth/data/repo_implemen/auth_repo_implement.dart';
import 'package:marketi/feature/auth/domain/repo/auth_repo.dart';
import 'package:marketi/feature/cart/data/repo_implement/cart_repo_implement.dart';
import 'package:marketi/feature/cart/domain/repo/cart_repo.dart';
import 'package:marketi/feature/favorite/data/repo_implement/favorite_repo_implement.dart';
import 'package:marketi/feature/favorite/domain/repo/favorite_repo.dart';
import 'package:marketi/feature/home/data/repo_implement/home_repo_implement.dart.dart';
import 'package:marketi/feature/home/domain/repo/home_repo.dart';

final getIt = GetIt.instance;
void getItSetUp() {
  getIt.registerSingleton<AuthRepo>(AuthRepoImplement(ApiServices(Dio())));
  getIt.registerSingleton<HomeRepo>(HomeRepoImplement(ApiServices(Dio())));
  getIt.registerSingleton<CartRepo>(CartRepoImplement(ApiServices(Dio())));
  getIt.registerSingleton<FavoriteRepo>(
    FavoriteRepoImplement(ApiServices(Dio())),
  );
}
