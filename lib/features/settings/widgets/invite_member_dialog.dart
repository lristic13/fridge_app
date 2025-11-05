import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/core/utils/ui_helpers.dart';
import 'package:fridge_app/features/settings/controllers/invite_member_controller.dart';
import 'package:fridge_app/features/settings/utils/settings_handlers.dart';
import 'package:fridge_app/widgets/app_primary_button.dart';

class InviteMemberDialog extends ConsumerStatefulWidget {
  const InviteMemberDialog({super.key});

  @override
  ConsumerState<InviteMemberDialog> createState() => _InviteMemberDialogState();
}

class _InviteMemberDialogState extends ConsumerState<InviteMemberDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inviteState = ref.watch(inviteMemberControllerProvider);

    ref.listen(inviteMemberControllerProvider, (previous, next) {
      if (next.errorMessage != null) {
        UiHelpers.showErrorSnackBar(context, next.errorMessage!);
      }
    });

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person_add,
                        color: AppColors.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          AppStrings.inviteMember,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Enter the email address of the user you want to invite to this fridge',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'user@example.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter an email address';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onFieldSubmitted:
                        (_) => SettingsHandlers.handleInviteMember(
                          context: context,
                          ref: ref,
                          formKey: _formKey,
                          email: _emailController.text,
                        ),
                  ),
                  const SizedBox(height: 24),
                  AppPrimaryButton(
                    text: 'Send Invite',
                    onPressed:
                        () => SettingsHandlers.handleInviteMember(
                          context: context,
                          ref: ref,
                          formKey: _formKey,
                          email: _emailController.text,
                        ),
                    isLoading: inviteState.isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
