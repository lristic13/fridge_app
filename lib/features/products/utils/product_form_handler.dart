import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/auth_provider.dart';
import 'package:fridge_app/core/providers/selected_fridge_provider.dart';
import 'package:fridge_app/core/utils/ui_helpers.dart';
import 'package:fridge_app/features/products/add/controllers/add_product_controller.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';
import 'package:fridge_app/features/products/edit/controllers/edit_product_controller.dart';
import 'package:go_router/go_router.dart';

class ProductFormHandler {
  ProductFormHandler._();

  static Future<void> handleAddProduct({
    required BuildContext context,
    required WidgetRef ref,
    required GlobalKey<FormState> formKey,
    required String name,
    required DateTime? bestBefore,
    required ProductType? type,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (bestBefore == null) {
      UiHelpers.showErrorSnackBar(context, 'Please select a best before date');
      return;
    }

    if (type == null) {
      UiHelpers.showErrorSnackBar(context, 'Please select a product type');
      return;
    }

    final authRepository = ref.read(authRepositoryProvider);
    final userId = authRepository.currentUser?.uid;

    if (userId == null) {
      UiHelpers.showErrorSnackBar(context, 'User not authenticated');
      return;
    }

    final selectedFridge = ref.read(selectedFridgeProvider);
    if (selectedFridge == null) {
      UiHelpers.showErrorSnackBar(context, 'No fridge selected');
      return;
    }

    final controller = ref.read(addProductControllerProvider.notifier);
    final success = await controller.addProduct(
      userId: userId,
      fridgeId: selectedFridge.id,
      name: name.trim(),
      bestBefore: bestBefore,
      type: type,
    );

    if (success && context.mounted) {
      context.pop();
    }
  }

  static Future<void> handleEditProduct({
    required BuildContext context,
    required WidgetRef ref,
    required GlobalKey<FormState> formKey,
    required ProductModel product,
    required String name,
    required DateTime bestBefore,
    required ProductType type,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    final controller = ref.read(editProductControllerProvider.notifier);
    final success = await controller.updateProduct(
      productId: product.id,
      userId: product.userId,
      fridgeId: product.fridgeId,
      name: name.trim(),
      timeStored: product.timeStored,
      bestBefore: bestBefore,
      type: type,
    );

    if (success && context.mounted) {
      context.pop();
      UiHelpers.showSuccessSnackBar(context, 'Product updated successfully');
    }
  }
}
