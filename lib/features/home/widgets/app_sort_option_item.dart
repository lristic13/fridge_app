import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/home/models/product_sort_option.dart';

class AppSortOptionItem extends StatelessWidget {
  final ProductSortOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const AppSortOptionItem({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  IconData _getIconForOption(ProductSortOption option) {
    switch (option) {
      case ProductSortOption.timeStored:
        return Icons.access_time_outlined;
      case ProductSortOption.bestBefore:
        return Icons.calendar_today_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary.withValues(alpha: 0.05)
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
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _getIconForOption(option),
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.displayName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color:
                          isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    option.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
