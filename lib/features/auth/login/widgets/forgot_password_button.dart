import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';

/// Forgot password button widget
class AppForgotPasswordButton extends StatelessWidget {
  const AppForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password
        },
        child: const Text(
          AppStrings.forgotPassword,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
