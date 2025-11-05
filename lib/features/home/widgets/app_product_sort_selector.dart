import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/home/models/product_sort_option.dart';
import 'package:fridge_app/features/home/widgets/app_sort_option_item.dart';

class AppProductSortBottomSheet extends StatelessWidget {
  final ProductSortOption selectedOption;

  const AppProductSortBottomSheet({super.key, required this.selectedOption});

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Sort By',
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
              itemCount: ProductSortOption.values.length,
              itemBuilder: (context, index) {
                final option = ProductSortOption.values[index];
                final isSelected = option == selectedOption;

                return AppSortOptionItem(
                  option: option,
                  isSelected: isSelected,
                  onTap: () {
                    Navigator.of(context).pop(option);
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
