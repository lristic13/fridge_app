import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_product_state.freezed.dart';

@freezed
class EditProductState with _$EditProductState {
  const factory EditProductState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool isSuccess,
  }) = _EditProductState;
}
