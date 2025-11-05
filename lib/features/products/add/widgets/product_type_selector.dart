import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';

class AppProductTypeSelector {
  static Future<ProductType?> show(
    BuildContext context, {
    ProductType? selectedType,
  }) async {
    return await showModalBottomSheet<ProductType>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _ProductTypeBottomSheet(selectedType: selectedType),
    );
  }
}

class _ProductTypeBottomSheet extends StatelessWidget {
  final ProductType? selectedType;

  const _ProductTypeBottomSheet({this.selectedType});

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
              child: Text(
                'Select Product Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ProductType.values.length,
              itemBuilder: (context, index) {
                final type = ProductType.values[index];
                final isSelected = type == selectedType;

                return _ProductTypeItem(
                  type: type,
                  isSelected: isSelected,
                  onTap: () {
                    Navigator.of(context).pop(type);
                  },
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ProductTypeItem extends StatelessWidget {
  final ProductType type;
  final bool isSelected;
  final VoidCallback onTap;

  const _ProductTypeItem({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary.withValues(alpha: .05)
                  : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.primary.withValues(alpha: .1)
                        : AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                type.icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                type.displayName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 24),
          ],
        ),
      ),
    );
  }
}
