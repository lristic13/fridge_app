import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/features/auth/register/controllers/register_controller.dart';
import 'package:fridge_app/features/auth/register/widgets/register_confirm_password_field.dart';
import 'package:fridge_app/features/auth/register/widgets/register_email_field.dart';
import 'package:fridge_app/features/auth/register/widgets/register_header.dart';
import 'package:fridge_app/features/auth/register/widgets/register_password_field.dart';
import 'package:fridge_app/features/auth/register/widgets/sign_in_prompt.dart';
import 'package:fridge_app/features/auth/utils/auth_handlers.dart';
import 'package:fridge_app/widgets/app_error_message.dart';
import 'package:fridge_app/widgets/app_primary_button.dart';

/// Register screen
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const AppRegisterHeader(),
                const SizedBox(height: 48),
                AppRegisterEmailField(controller: _emailController),
                const SizedBox(height: 16),
                AppRegisterPasswordField(controller: _passwordController),
                const SizedBox(height: 16),
                AppRegisterConfirmPasswordField(
                  controller: _confirmPasswordController,
                  onSubmitted:
                      () => AuthHandlers.handleRegister(
                        context: context,
                        ref: ref,
                        formKey: _formKey,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                ),
                const SizedBox(height: 24),
                if (registerState.errorMessage != null) ...[
                  AppErrorMessage(message: registerState.errorMessage!),
                  const SizedBox(height: 16),
                ],
                AppPrimaryButton(
                  text: AppStrings.register,
                  onPressed:
                      () => AuthHandlers.handleRegister(
                        context: context,
                        ref: ref,
                        formKey: _formKey,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                  isLoading: registerState.isLoading,
                ),
                const SizedBox(height: 24),
                const AppSignInPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
