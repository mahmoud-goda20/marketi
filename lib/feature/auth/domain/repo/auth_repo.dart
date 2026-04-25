import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/falier.dart';
import 'package:marketi/feature/auth/domain/entites/auth_entites.dart';

abstract class AuthRepo {
  Future<Either<Failer, AuthEntity>> login(String email, String password);

  Future<Either<Failer, AuthEntity>> register(
    String name,
    String phone,
    String email,
    String password,
    String confirmPassword,
  );


  Future<Either<Failer, void>> resetPassword(
    String email,
    String newPassword,
    String confirmPassword,
  );

  Future<Either<Failer, void>> sendForgetPasswordCodeWithEmail(String email);

  Future<Either<Failer, void>> verifyEmailCode(String email, String code);
}
