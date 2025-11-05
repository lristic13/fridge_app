import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';

/// Horizontal scrollable list of product type filter chips
class AppProductTypeChips extends StatelessWidget {
  final Set<ProductType> selectedTypes;
  final Function(Set<ProductType>) onSelectionChanged;

  const AppProductTypeChips({
    super.key,
    required this.selectedTypes,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isAllSelected = selectedTypes.isEmpty;

    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // "All" chip
          _buildChip(
            label: 'All',
            icon: Icons.grid_view,
            isSelected: isAllSelected,
            onTap: () {
              if (!isAllSelected) {
                onSelectionChanged({});
              }
            },
          ),
          const SizedBox(width: 8),
          // Product type chips
          ...ProductType.values.map((type) {
            final isSelected = selectedTypes.contains(type);
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildChip(
                label: type.displayName,
                icon: type.icon,
                isSelected: isSelected,
                onTap: () {
                  final newSelection = Set<ProductType>.from(selectedTypes);
                  if (isSelected) {
                    newSelection.remove(type);
                  } else {
                    newSelection.add(type);
                  }
                  onSelectionChanged(newSelection);
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
