import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/utils/app_exception.dart';
import 'package:fridge_app/features/auth/data/repositories/auth_repository.dart';
import 'package:fridge_app/features/auth/register/models/register_state.dart';

/// Register controller using Riverpod StateNotifier
class RegisterController extends StateNotifier<RegisterState> {
  final AuthRepository _authRepository;

  RegisterController(this._authRepository) : super(const RegisterState());

  /// Register with email and password
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _authRepository.register(
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

/// Provider for RegisterController
final registerControllerProvider =
    StateNotifierProvider<RegisterController, RegisterState>((ref) {
  return RegisterController(AuthRepository());
});
