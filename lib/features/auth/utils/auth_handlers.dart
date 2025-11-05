import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/features/auth/login/controllers/login_controller.dart';
import 'package:fridge_app/features/auth/register/controllers/register_controller.dart';
import 'package:go_router/go_router.dart';

/// Authentication handler utility class
class AuthHandlers {
  AuthHandlers._();

  /// Handle login submission
  static Future<void> handleLogin({
    required BuildContext context,
    required WidgetRef ref,
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      final controller = ref.read(loginControllerProvider.notifier);
      final success = await controller.signIn(
        email: email.trim(),
        password: password,
      );

      if (success && context.mounted) {
        context.go('/home');
      }
    }
  }

  /// Handle registration submission
  static Future<void> handleRegister({
    required BuildContext context,
    required WidgetRef ref,
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      final controller = ref.read(registerControllerProvider.notifier);
      final success = await controller.register(
        email: email.trim(),
        password: password,
      );

      if (success && context.mounted) {
        context.go('/home');
      }
    }
  }
}
