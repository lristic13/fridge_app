import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:go_router/go_router.dart';

/// Sign in prompt widget
class AppSignInPrompt extends StatelessWidget {
  const AppSignInPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          AppStrings.alreadyHaveAccount,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text(
            AppStrings.signIn,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
