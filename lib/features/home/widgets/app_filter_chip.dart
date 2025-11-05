import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';

class AppFilterChip extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onTap;

  const AppFilterChip({
    super.key,
    required this.selectedCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasFilters = selectedCount > 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: hasFilters ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hasFilters ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.filter_list,
              size: 18,
              color: hasFilters ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              hasFilters ? 'Filter ($selectedCount)' : 'Filter',
              style: TextStyle(
                fontSize: 14,
                color: hasFilters ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: hasFilters ? Colors.white : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
