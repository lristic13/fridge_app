import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/providers/product_provider.dart';
import 'package:fridge_app/core/router/app_routes.dart';
import 'package:fridge_app/features/home/widgets/app_product_actions_sheet.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:go_router/go_router.dart';

class ProductActionHandler {
  ProductActionHandler._();

  static Future<void> handleProductAction({
    required BuildContext context,
    required ProductModel product,
    required WidgetRef ref,
  }) async {
    final action = await AppProductActionsSheet.show(context, product: product);

    if (action == null || !context.mounted) return;

    switch (action) {
      case ProductAction.edit:
        handleEditProduct(context: context, product: product);
        break;
      case ProductAction.delete:
        await handleDeleteProduct(context: context, product: product, ref: ref);
        break;
      case ProductAction.duplicate:
        handleDuplicateProduct(context: context, product: product);
        break;
    }
  }

  static void handleEditProduct({
    required BuildContext context,
    required ProductModel product,
  }) {
    context.push(AppRoutes.editProduct, extra: product);
  }

  static Future<void> handleDeleteProduct({
    required BuildContext context,
    required ProductModel product,
    required WidgetRef ref,
  }) async {
    final confirmed = await _showDeleteConfirmation(
      context: context,
      product: product,
    );

    if (confirmed == true && context.mounted) {
      final productRepository = ref.read(productRepositoryProvider);
      try {
        await productRepository.deleteProduct(product.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product deleted successfully'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete product: $e'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }

  /// Navigate to add product screen with product data for duplication
  static void handleDuplicateProduct({
    required BuildContext context,
    required ProductModel product,
  }) {
    context.push('/add-product', extra: product);
  }

  /// Show delete confirmation dialog
  static Future<bool?> _showDeleteConfirmation({
    required BuildContext context,
    required ProductModel product,
  }) {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Product'),
            content: Text(
              'Are you sure you want to delete "${product.name}"? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }
}
