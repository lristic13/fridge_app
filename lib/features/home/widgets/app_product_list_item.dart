import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/home/widgets/app_product_item_action_button.dart';
import 'package:fridge_app/features/home/widgets/app_product_item_content.dart';
import 'package:fridge_app/features/home/widgets/app_product_item_expiry_badge.dart';
import 'package:fridge_app/features/home/widgets/app_product_item_icon.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';

class AppProductListItem extends StatelessWidget {
  final ProductModel product;

  final VoidCallback? onActionTap;

  const AppProductListItem({
    super.key,
    required this.product,

    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              product.isExpired || product.isExpiringSoon
                  ? product.expiryColor.withValues(alpha: 0.3)
                  : AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          AppProductItemIcon(type: product.type),
          const SizedBox(width: 16),
          Expanded(child: AppProductItemContent(product: product)),
          AppProductItemExpiryBadge(product: product),
          const SizedBox(width: 8),
          AppProductItemActionButton(onPressed: onActionTap),
        ],
      ),
    );
  }
}
