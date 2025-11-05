import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/widgets/app_text_field.dart';

/// Register confirm password input field widget
class AppRegisterConfirmPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSubmitted;

  const AppRegisterConfirmPasswordField({
    super.key,
    required this.controller,
    this.onSubmitted,
  });

  @override
  State<AppRegisterConfirmPasswordField> createState() =>
      _AppRegisterConfirmPasswordFieldState();
}

class _AppRegisterConfirmPasswordFieldState
    extends State<AppRegisterConfirmPasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      hintText: AppStrings.confirmPassword,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      onSubmitted: widget.onSubmitted != null ? (_) => widget.onSubmitted!() : null,
      prefixIcon: const Icon(Icons.lock_outlined),
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
    );
  }
}
