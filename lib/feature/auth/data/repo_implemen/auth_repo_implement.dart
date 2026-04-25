import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketi/core/errors/falier.dart';
import 'package:marketi/core/services/api/data_base_sevices.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';
import 'package:marketi/feature/auth/data/models/auth_model.dart';
import 'package:marketi/feature/auth/domain/entites/auth_entites.dart';
import 'package:marketi/feature/auth/domain/repo/auth_repo.dart';

class AuthRepoImplement extends AuthRepo {
  DataBaseServices dataBaseServices;
  AuthRepoImplement(this.dataBaseServices);
  final token = PreferenceManager.instance.getString('token');
  @override
  Future<Either<Failer, AuthEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await dataBaseServices.postData(
        path: "/auth/signIn",
        data: {"email": email, "password": password},
      );

      final authModel = AuthModel.fromJson(response);

      return right(authModel.toEntity());
    } on DioException catch (e) {
      return left(ApiError.fromDioException(e));
    } catch (e) {
      return left(ApiError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failer, AuthEntity>> register(
    String name,
    String phone,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await dataBaseServices.postData(
        path: "/auth/signUp",
        data: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );

      final authModel = AuthModel.fromJson(response);

      return right(authModel.toEntity());
    } on DioException catch (e) {
      return left(ApiError.fromDioException(e));
    } catch (e) {
      return left(ApiError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failer, void>> resetPassword(
    String email,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      await dataBaseServices.postData(
        path: '/auth/resetPassword',
        data: {
          'email': email,
          'password': newPassword,
          'confirmPassword': confirmPassword,
        },
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return left(ApiError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failer, void>> sendForgetPasswordCodeWithEmail(
    String email,
  ) async {
    try {
      await dataBaseServices.postData(
        path: '/auth/resetPassCode',
        data: {'email': email},
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return left(ApiError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failer, void>> verifyEmailCode(
    String email,
    String code,
  ) async {
    try {
      await dataBaseServices.postData(
        path: '/auth/activeResetPass',
        data: {'email': email, 'code': code},
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiError.fromDioException(e));
    } catch (e) {
      return left(ApiError(errorMessage: e.toString()));
    }
  }
}
