import 'package:bloc/bloc.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';
import 'dart:convert';

part 'ui_state.dart';

class UiCubit extends Cubit<UiState> {
  UiCubit() : super(const UiState()) {
    _loadFavorites();
  }

  void _loadFavorites() {
    final savedFavorites = PreferenceManager.instance.getString('favorites');
    if (savedFavorites != null) {
      final Map<String, dynamic> decoded = jsonDecode(savedFavorites);
      final Map<int, bool> favorites = decoded.map(
        (key, value) => MapEntry(int.parse(key), value as bool),
      );
      emit(state.copyWith(favorites: favorites));
    }
  }

  Future<void> _saveFavorites(Map<int, bool> favorites) async {
    final Map<String, bool> stringMap = favorites.map(
      (key, value) => MapEntry(key.toString(), value),
    );
    await PreferenceManager.instance.setString(
      'favorites',
      jsonEncode(stringMap),
    );
  }

  void toggleFavorite(int productId) async {
    final updatedFavorites = Map<int, bool>.from(state.favorites);
    updatedFavorites[productId] = !(updatedFavorites[productId] ?? false);
    await _saveFavorites(updatedFavorites);
    emit(state.copyWith(favorites: updatedFavorites));
  }

  bool isFavorite(int productId) => state.favorites[productId] ?? false;

  void togglePasswordVisibility() =>
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));

  void toggleConfirmPasswordVisibility() => emit(
    state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
  );

  void toggleNotification() =>
      emit(state.copyWith(isNotification: !state.isNotification));

  void toggleDarkMode() => emit(state.copyWith(isDarkMode: !state.isDarkMode));

  void toggleRememberMe() =>
      emit(state.copyWith(isRememberMe: !state.isRememberMe));
}
