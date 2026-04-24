part of 'ui_cubit.dart';


class UiState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isNotification;
  final bool isDarkMode;
  final bool isRememberMe;
  final Map<int, bool> favorites;

  const UiState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isNotification = false,
    this.isDarkMode = false,
    this.isRememberMe = false,
    this.favorites = const {},
  });

  UiState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isNotification,
    bool? isDarkMode,
    bool? isRememberMe,
    Map<int, bool>? favorites,
  }) {
    return UiState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isNotification: isNotification ?? this.isNotification,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      favorites: favorites ?? this.favorites,
    );
  }
}