import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:intl/intl.dart';

class AppProductItemExpiryBadge extends StatelessWidget {
  final ProductModel product;

  const AppProductItemExpiryBadge({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: product.expiryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            product.expiryText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: product.expiryColor,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          DateFormat('MMM dd').format(product.bestBefore),
          style: const TextStyle(fontSize: 12, color: AppColors.textHint),
        ),
      ],
    );
  }
}
