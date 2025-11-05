import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/widgets/app_text_field.dart';

/// Login password input field widget
class AppLoginPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSubmitted;

  const AppLoginPasswordField({
    super.key,
    required this.controller,
    this.onSubmitted,
  });

  @override
  State<AppLoginPasswordField> createState() => _AppLoginPasswordFieldState();
}

class _AppLoginPasswordFieldState extends State<AppLoginPasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      hintText: AppStrings.password,
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
