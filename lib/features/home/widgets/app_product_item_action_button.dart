import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';

class AppProductItemActionButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppProductItemActionButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert),
      color: AppColors.textSecondary,
      iconSize: 20,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      onPressed: onPressed,
    );
  }
}
