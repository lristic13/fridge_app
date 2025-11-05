import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

/// Register screen state model using Freezed
@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _RegisterState;
}
