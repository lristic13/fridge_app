import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/core/router/app_routes.dart';
import 'package:fridge_app/widgets/app_primary_button.dart';
import 'package:go_router/go_router.dart';

class AppEmptyFridgesState extends StatelessWidget {
  const AppEmptyFridgesState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.kitchen_outlined,
              size: 80,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.noFridgesYet,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.createYourFirstFridgeDescription,
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AppPrimaryButton(
              text: AppStrings.createYourFirstFridge,
              onPressed: () {
                context.push(AppRoutes.createFridge);
              },
            ),
          ],
        ),
      ),
    );
  }
}
