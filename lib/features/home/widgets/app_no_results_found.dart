import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';

class AppNoResultsFound extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const AppNoResultsFound({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text(
            title ?? AppStrings.noProductsFound,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle ?? 'Try adjusting your filters',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
