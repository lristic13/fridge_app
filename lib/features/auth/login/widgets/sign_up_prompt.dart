import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/core/router/app_routes.dart';
import 'package:go_router/go_router.dart';

/// Sign up prompt widget
class AppSignUpPrompt extends StatelessWidget {
  const AppSignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          AppStrings.dontHaveAccount,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            context.push(AppRoutes.register);
          },
          child: const Text(
            AppStrings.signUp,
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
