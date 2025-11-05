import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/utils/app_exception.dart';
import 'package:fridge_app/features/auth/data/repositories/auth_repository.dart';
import 'package:fridge_app/features/auth/login/models/login_state.dart';

/// Login controller using Riverpod StateNotifier
class LoginController extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(const LoginState());

  /// Sign in with email and password
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _authRepository.signIn(
        email: email,
        password: password,
      );

      state = state.copyWith(isLoading: false);
      return true;
    } on AppException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred',
      );
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider for LoginController
final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(AuthRepository());
});
