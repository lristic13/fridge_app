import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/auth_provider.dart';
import 'package:fridge_app/core/providers/fridge_provider.dart';
import 'package:fridge_app/core/providers/product_provider.dart';
import 'package:fridge_app/core/providers/selected_fridge_provider.dart';
import 'package:fridge_app/core/utils/ui_helpers.dart';
import 'package:fridge_app/features/settings/controllers/invite_member_controller.dart';
import 'package:fridge_app/features/settings/controllers/settings_controller.dart';
import 'package:go_router/go_router.dart';

class SettingsHandlers {
  SettingsHandlers._();

  static Future<void> handleUpdateFridgeName({
    required BuildContext context,
    required WidgetRef ref,
    required GlobalKey<FormState> formKey,
    required String newName,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final selectedFridge = ref.read(selectedFridgeProvider);
    if (selectedFridge == null) {
      UiHelpers.showErrorSnackBar(context, 'No fridge selected');
      return;
    }

    if (newName.trim() == selectedFridge.name) {
      UiHelpers.showErrorSnackBar(context, 'Name is unchanged');
      return;
    }

    final controller = ref.read(settingsControllerProvider.notifier);
    final success = await controller.updateFridgeName(
      fridge: selectedFridge,
      newName: newName.trim(),
    );

    if (success && context.mounted) {
      final updatedFridge = selectedFridge.copyWith(name: newName.trim());
      await ref
          .read(selectedFridgeProvider.notifier)
          .setSelectedFridge(updatedFridge);
      UiHelpers.showSuccessSnackBar(context, 'Fridge name updated');
    }
  }

  static Future<void> handleSwitchFridge({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    context.push('/fridge-selection', extra: 'manual');
  }

  static Future<void> handleLogout({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.signOut();

    await ref.read(selectedFridgeProvider.notifier).clearSelectedFridge();

    ref.invalidate(userFridgesProvider);
    ref.invalidate(userProductsProvider);
    ref.invalidate(selectedFridgeProvider);

    if (context.mounted) {
      context.go('/login');
    }
  }

  static Future<void> handleInviteMember({
    required BuildContext context,
    required WidgetRef ref,
    required GlobalKey<FormState> formKey,
    required String email,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final selectedFridge = ref.read(selectedFridgeProvider);
    if (selectedFridge == null) {
      UiHelpers.showErrorSnackBar(context, 'No fridge selected');
      return;
    }

    final authRepository = ref.read(authRepositoryProvider);
    final currentUserId = authRepository.currentUser?.uid;

    if (currentUserId == null) {
      UiHelpers.showErrorSnackBar(context, 'User not authenticated');
      return;
    }

    final controller = ref.read(inviteMemberControllerProvider.notifier);
    final success = await controller.inviteMember(
      fridgeId: selectedFridge.id,
      currentUserId: currentUserId,
      email: email.trim(),
    );

    if (success && context.mounted) {
      Navigator.of(context).pop();
      UiHelpers.showSuccessSnackBar(context, 'Member invited successfully');
    }
  }
}
