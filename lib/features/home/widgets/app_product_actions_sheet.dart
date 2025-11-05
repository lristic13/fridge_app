import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/home/widgets/app_action_item.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';

/// Product actions modal bottom sheet
class AppProductActionsSheet {
  /// Show product actions modal
  static Future<ProductAction?> show(
    BuildContext context, {
    required ProductModel product,
  }) async {
    return await showModalBottomSheet<ProductAction>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _ProductActionsBottomSheet(product: product),
    );
  }
}

/// Product action enum
enum ProductAction { edit, delete, duplicate }

class _ProductActionsBottomSheet extends StatelessWidget {
  final ProductModel product;

  const _ProductActionsBottomSheet({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.type.displayName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppActionItem(
              icon: Icons.edit_outlined,
              label: 'Edit Product',
              onTap: () {
                Navigator.of(context).pop(ProductAction.edit);
              },
            ),
            AppActionItem(
              icon: Icons.content_copy_outlined,
              label: 'Duplicate',
              onTap: () {
                Navigator.of(context).pop(ProductAction.duplicate);
              },
            ),
            AppActionItem(
              icon: Icons.delete_outline,
              label: 'Delete',
              isDestructive: true,
              onTap: () {
                Navigator.of(context).pop(ProductAction.delete);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
