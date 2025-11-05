import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:intl/intl.dart';

class AppProductItemContent extends StatelessWidget {
  final ProductModel product;

  const AppProductItemContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          product.type.displayName,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          'Added: ${DateFormat('MMM dd, yyyy').format(product.timeStored)}',
          style: const TextStyle(fontSize: 12, color: AppColors.textHint),
        ),
      ],
    );
  }
}
