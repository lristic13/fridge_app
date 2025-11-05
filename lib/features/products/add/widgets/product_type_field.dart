import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';

class AppProductTypeField extends StatelessWidget {
  final ProductType? selectedType;
  final VoidCallback onTap;

  const AppProductTypeField({
    super.key,
    required this.selectedType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.category_outlined,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedType?.displayName ?? 'Select type',
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          selectedType != null
                              ? AppColors.textPrimary
                              : AppColors.textHint,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
