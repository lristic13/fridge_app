import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/utils/app_exception.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';
import 'package:fridge_app/features/products/data/repositories/product_repository.dart';
import 'package:fridge_app/features/products/edit/models/edit_product_state.dart';

class EditProductController extends StateNotifier<EditProductState> {
  final ProductRepository _productRepository;

  EditProductController(this._productRepository)
    : super(const EditProductState());

  Future<bool> updateProduct({
    required String productId,
    required String userId,
    required String fridgeId,
    required String name,
    required DateTime timeStored,
    required DateTime bestBefore,
    required ProductType type,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final product = ProductModel(
        id: productId,
        userId: userId,
        fridgeId: fridgeId,
        name: name,
        timeStored: timeStored,
        bestBefore: bestBefore,
        type: type,
      );

      await _productRepository.updateProduct(product);

      state = state.copyWith(isLoading: false, isSuccess: true);
      return true;
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred',
      );
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void reset() {
    state = const EditProductState();
  }
}

final editProductControllerProvider =
    StateNotifierProvider<EditProductController, EditProductState>((ref) {
      return EditProductController(ProductRepository());
    });
