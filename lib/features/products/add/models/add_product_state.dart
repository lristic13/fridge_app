import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_product_state.freezed.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool isSuccess,
  }) = _AddProductState;
}
