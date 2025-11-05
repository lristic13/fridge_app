import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/features/auth/login/controllers/login_controller.dart';
import 'package:fridge_app/features/auth/login/widgets/forgot_password_button.dart';
import 'package:fridge_app/features/auth/login/widgets/login_email_field.dart';
import 'package:fridge_app/features/auth/login/widgets/login_header.dart';
import 'package:fridge_app/features/auth/login/widgets/login_password_field.dart';
import 'package:fridge_app/features/auth/login/widgets/sign_up_prompt.dart';
import 'package:fridge_app/features/auth/utils/auth_handlers.dart';
import 'package:fridge_app/widgets/app_error_message.dart';
import 'package:fridge_app/widgets/app_primary_button.dart';

/// Login screen
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

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
                const SizedBox(height: 60),
                const AppLoginHeader(),
                const SizedBox(height: 48),
                AppLoginEmailField(controller: _emailController),
                const SizedBox(height: 16),
                AppLoginPasswordField(
                  controller: _passwordController,
                  onSubmitted:
                      () => AuthHandlers.handleLogin(
                        context: context,
                        ref: ref,
                        formKey: _formKey,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                ),
                const SizedBox(height: 8),
                const AppForgotPasswordButton(),
                const SizedBox(height: 24),
                if (loginState.errorMessage != null) ...[
                  AppErrorMessage(message: loginState.errorMessage!),
                  const SizedBox(height: 16),
                ],
                AppPrimaryButton(
                  text: AppStrings.signIn,
                  onPressed:
                      () => AuthHandlers.handleLogin(
                        context: context,
                        ref: ref,
                        formKey: _formKey,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                  isLoading: loginState.isLoading,
                ),
                const SizedBox(height: 24),
                const AppSignUpPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
