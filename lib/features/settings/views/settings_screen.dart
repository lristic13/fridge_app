import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/core/providers/selected_fridge_provider.dart';
import 'package:fridge_app/core/utils/ui_helpers.dart';
import 'package:fridge_app/features/settings/controllers/settings_controller.dart';
import 'package:fridge_app/features/settings/utils/settings_handlers.dart';
import 'package:fridge_app/features/settings/widgets/invite_member_dialog.dart';
import 'package:fridge_app/features/settings/widgets/settings_list_tile.dart';
import 'package:fridge_app/features/settings/widgets/settings_section.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final selectedFridge = ref.read(selectedFridgeProvider);
    _nameController = TextEditingController(text: selectedFridge?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsControllerProvider);
    final selectedFridge = ref.watch(selectedFridgeProvider);

    ref.listen(settingsControllerProvider, (previous, next) {
      if (next.errorMessage != null) {
        UiHelpers.showErrorSnackBar(context, next.errorMessage!);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(AppStrings.settings)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              AppSettingsSection(
                title: AppStrings.fridgeSettings,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: AppStrings.fridgeName,
                              prefixIcon: const Icon(Icons.label_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return AppStrings.errorFridgeNameRequired;
                              }
                              if (value.trim().length > 50) {
                                return AppStrings.errorFridgeNameTooLong;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed:
                                settingsState.isLoading
                                    ? null
                                    : () =>
                                        SettingsHandlers.handleUpdateFridgeName(
                                          context: context,
                                          ref: ref,
                                          formKey: _formKey,
                                          newName: _nameController.text,
                                        ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child:
                                settingsState.isLoading
                                    ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                    : Text(AppStrings.saveChanges),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSettingsListTile(
                    icon: Icons.swap_horiz,
                    title: AppStrings.switchFridge,
                    subtitle: AppStrings.selectDifferentFridge,
                    onTap:
                        () => SettingsHandlers.handleSwitchFridge(
                          context: context,
                          ref: ref,
                        ),
                  ),
                  AppSettingsListTile(
                    icon: Icons.person_add,
                    title: AppStrings.inviteMember,
                    subtitle: AppStrings.shareFridge,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const InviteMemberDialog(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppSettingsSection(
                title: AppStrings.account,
                children: [
                  AppSettingsListTile(
                    icon: Icons.logout,
                    title: AppStrings.logout,
                    subtitle: AppStrings.signOutOfYourAccount,
                    onTap: () => SettingsHandlers.handleLogout(
                      context: context,
                      ref: ref,
                    ),
                    iconColor: AppColors.error,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
