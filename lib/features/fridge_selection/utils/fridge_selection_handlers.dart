import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/auth_provider.dart';
import 'package:fridge_app/core/utils/ui_helpers.dart';
import 'package:fridge_app/features/fridge_selection/controllers/create_fridge_controller.dart';
import 'package:go_router/go_router.dart';

class FridgeSelectionHandlers {
  FridgeSelectionHandlers._();

  static Future<void> handleCreateFridge({
    required BuildContext context,
    required WidgetRef ref,
    required GlobalKey<FormState> formKey,
    required String name,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final authRepository = ref.read(authRepositoryProvider);
    final userId = authRepository.currentUser?.uid;

    if (userId == null) {
      UiHelpers.showErrorSnackBar(context, 'User not authenticated');
      return;
    }

    final controller = ref.read(createFridgeControllerProvider.notifier);
    final success = await controller.createFridge(
      userId: userId,
      name: name.trim(),
    );

    if (success && context.mounted) {
      context.pop();
    }
  }
}
