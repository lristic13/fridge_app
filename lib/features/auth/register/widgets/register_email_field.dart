import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/widgets/app_text_field.dart';

/// Register email input field widget
class AppRegisterEmailField extends StatelessWidget {
  final TextEditingController controller;

  const AppRegisterEmailField({
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
