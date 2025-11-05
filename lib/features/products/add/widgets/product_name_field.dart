import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/widgets/app_text_field.dart';

class AppProductNameField extends StatelessWidget {
  final TextEditingController controller;

  const AppProductNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Name',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        AppTextField(
          controller: controller,
          hintText: 'Enter product name',
          prefixIcon: const Icon(Icons.shopping_basket_outlined),
        ),
      ],
    );
  }
}
