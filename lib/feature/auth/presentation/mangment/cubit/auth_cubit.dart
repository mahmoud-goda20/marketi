import 'package:bloc/bloc.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';
import 'package:marketi/feature/auth/domain/entites/auth_entites.dart';
import 'package:marketi/feature/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepo.login(email, password);
    result.fold(
      (failure) => emit(AuthFailure(errorMessage: failure.errorMessage)),
      (authEntity) async {
        await PreferenceManager.instance.setString('token', authEntity.token);
        await PreferenceManager.instance.setString('name', authEntity.name);
        emit(AuthSuccess(authEntity: authEntity));
      },
    );
  }

  Future<void> register(
    String name,
    String phone,
    String email,
    String password,
    String confirmPassword,
  ) async {
    emit(AuthLoading());
    final result = await authRepo.register(
      name,
      phone,
      email,
      password,
      confirmPassword,
    );
    result.fold(
      (failure) => emit(AuthFailure(errorMessage: failure.errorMessage)),
      (authEntity) async {
        await PreferenceManager.instance.setString('token', authEntity.token);
        await PreferenceManager.instance.setString('name', authEntity.name);
        emit(AuthSuccess(authEntity: authEntity));
      },
    );
  }

  Future<void> sendForgetPasswordCode(String email) async {
    emit(AuthLoading());
    final result = await authRepo.sendForgetPasswordCodeWithEmail(email);
    result.fold(
      (failure) => emit(AuthFailure(errorMessage: failure.errorMessage)),
      (_) => emit(AuthCodeSent()),
    );
  }

  Future<void> verifyEmailCode(String email, String code) async {
    emit(AuthLoading());
    final result = await authRepo.verifyEmailCode(email, code);
    result.fold(
      (failure) => emit(AuthFailure(errorMessage: failure.errorMessage)),
      (_) => emit(AuthCodeVerified()),
    );
  }

  Future<void> resetPassword(
    String email,
    String newPassword,
    String confirmPassword,
  ) async {
    print('🟡 resetPassword called: $email'); // ✅
    emit(AuthLoading());
    final result = await authRepo.resetPassword(
      email,
      newPassword,
      confirmPassword,
    );
    result.fold(
      (failure) {
        print('❌ Error: ${failure.errorMessage}'); // ✅
        emit(AuthFailure(errorMessage: failure.errorMessage));
      },
      (_) {
        print('✅ Password reset success'); // ✅
        emit(AuthPasswordReset());
      },
    );
  }
}
