import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/user_provider.dart';
import 'package:fridge_app/core/utils/app_exception.dart';
import 'package:fridge_app/features/auth/data/repositories/auth_repository.dart';
import 'package:fridge_app/features/auth/register/models/register_state.dart';
import 'package:fridge_app/features/users/data/repositories/user_repository.dart';

/// Register controller using Riverpod StateNotifier
class RegisterController extends StateNotifier<RegisterState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  RegisterController(this._authRepository, this._userRepository)
      : super(const RegisterState());

  /// Register with email and password
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final user = await _authRepository.register(
        email: email,
        password: password,
      );

      await _userRepository.createUser(
        userId: user.uid,
        email: email,
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
  final userRepository = ref.watch(userRepositoryProvider);
  return RegisterController(AuthRepository(), userRepository);
});
