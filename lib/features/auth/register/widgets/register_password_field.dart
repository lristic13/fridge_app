import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/widgets/app_text_field.dart';

/// Register password input field widget
class AppRegisterPasswordField extends StatefulWidget {
  final TextEditingController controller;

  const AppRegisterPasswordField({
    super.key,
    required this.controller,
  });

  @override
  State<AppRegisterPasswordField> createState() =>
      _AppRegisterPasswordFieldState();
}

class _AppRegisterPasswordFieldState extends State<AppRegisterPasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      hintText: AppStrings.password,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.next,
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
