import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/widgets/app_text_field.dart';

/// Login email input field widget
class AppLoginEmailField extends StatelessWidget {
  final TextEditingController controller;

  const AppLoginEmailField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      hintText: AppStrings.email,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      prefixIcon: const Icon(Icons.email_outlined),
    );
  }
}
