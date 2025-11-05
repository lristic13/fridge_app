import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:go_router/go_router.dart';

/// Register screen header widget
class AppRegisterHeader extends StatelessWidget {
  const AppRegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
        ),
        const SizedBox(height: 16),
        const Text(
          AppStrings.signUp,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Create an account to get started',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
