import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

/// Login screen state model using Freezed
@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _LoginState;
}
