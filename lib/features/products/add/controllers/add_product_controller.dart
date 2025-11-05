import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/utils/app_exception.dart';
import 'package:fridge_app/features/products/add/models/add_product_state.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';
import 'package:fridge_app/features/products/data/repositories/product_repository.dart';

class AddProductController extends StateNotifier<AddProductState> {
  final ProductRepository _productRepository;

  AddProductController(this._productRepository)
    : super(const AddProductState());

  Future<bool> addProduct({
    required String userId,
    required String fridgeId,
    required String name,
    required DateTime bestBefore,
    required ProductType type,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final product = ProductModel(
        id: '',
        userId: userId,
        fridgeId: fridgeId,
        name: name,
        timeStored: DateTime.now(),
        bestBefore: bestBefore,
        type: type,
      );

      await _productRepository.addProduct(product);

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
    state = const AddProductState();
  }
}

final addProductControllerProvider =
    StateNotifierProvider<AddProductController, AddProductState>((ref) {
      return AddProductController(ProductRepository());
    });
