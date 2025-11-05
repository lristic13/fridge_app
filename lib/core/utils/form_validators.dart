import 'package:fridge_app/core/constants/app_strings.dart';

class FormValidators {
  FormValidators._();

  static String? validateProductName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product name is required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value != password) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }
}
