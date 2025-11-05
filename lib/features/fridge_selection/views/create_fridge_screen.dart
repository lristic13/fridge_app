import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/utils/ui_helpers.dart';
import 'package:fridge_app/features/fridge_selection/controllers/create_fridge_controller.dart';
import 'package:fridge_app/features/fridge_selection/utils/fridge_selection_handlers.dart';
import 'package:fridge_app/widgets/app_primary_button.dart';
import 'package:go_router/go_router.dart';

class CreateFridgeScreen extends ConsumerStatefulWidget {
  const CreateFridgeScreen({super.key});

  @override
  ConsumerState<CreateFridgeScreen> createState() => _CreateFridgeScreenState();
}

class _CreateFridgeScreenState extends ConsumerState<CreateFridgeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createFridgeState = ref.watch(createFridgeControllerProvider);

    ref.listen(createFridgeControllerProvider, (previous, next) {
      if (next.errorMessage != null) {
        UiHelpers.showErrorSnackBar(context, next.errorMessage!);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Create Fridge'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.kitchen, size: 64, color: AppColors.primary),
                      const SizedBox(height: 24),
                      Text(
                        'Give your fridge a name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Choose a name that helps you identify this fridge',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Fridge Name',
                          hintText: 'e.g., Home Fridge, Office Kitchen',
                          prefixIcon: const Icon(Icons.label_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a fridge name';
                          }
                          if (value.trim().length > 50) {
                            return 'Name must be 50 characters or less';
                          }
                          return null;
                        },
                        onFieldSubmitted:
                            (_) => FridgeSelectionHandlers.handleCreateFridge(
                              context: context,
                              ref: ref,
                              formKey: _formKey,
                              name: _nameController.text,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: AppPrimaryButton(
                text: 'Create Fridge',
                onPressed:
                    () => FridgeSelectionHandlers.handleCreateFridge(
                      context: context,
                      ref: ref,
                      formKey: _formKey,
                      name: _nameController.text,
                    ),
                isLoading: createFridgeState.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
