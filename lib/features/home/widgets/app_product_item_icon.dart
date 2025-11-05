import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';

class AppProductItemIcon extends StatelessWidget {
  final ProductType type;

  const AppProductItemIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(type.icon, color: AppColors.primary, size: 24),
    );
  }
}
