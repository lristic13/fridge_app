import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/utils/ui_helpers.dart';
import 'package:fridge_app/features/products/add/widgets/product_best_before_field.dart';
import 'package:fridge_app/features/products/add/widgets/product_name_field.dart';
import 'package:fridge_app/features/products/add/widgets/product_type_field.dart';
import 'package:fridge_app/features/products/add/widgets/product_type_selector.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';
import 'package:fridge_app/features/products/edit/controllers/edit_product_controller.dart';
import 'package:fridge_app/features/products/utils/date_picker_helper.dart';
import 'package:fridge_app/features/products/utils/product_form_handler.dart';
import 'package:fridge_app/widgets/app_primary_button.dart';
import 'package:go_router/go_router.dart';

class EditProductScreen extends ConsumerStatefulWidget {
  final ProductModel product;

  const EditProductScreen({super.key, required this.product});

  @override
  ConsumerState<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends ConsumerState<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late ProductType _selectedType;
  late DateTime _selectedBestBefore;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _selectedType = widget.product.type;
    _selectedBestBefore = widget.product.bestBefore;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editProductState = ref.watch(editProductControllerProvider);

    ref.listen(editProductControllerProvider, (previous, next) {
      if (next.errorMessage != null) {
        UiHelpers.showErrorSnackBar(context, next.errorMessage!);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Edit Product'),
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
                      AppProductNameField(controller: _nameController),
                      const SizedBox(height: 20),
                      AppProductBestBeforeField(
                        selectedDate: _selectedBestBefore,
                        onTap: () async {
                          final picked = await DatePickerHelper.show(
                            context: context,
                            initialDate: _selectedBestBefore,
                          );
                          if (picked != null) {
                            setState(() {
                              _selectedBestBefore = picked;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      AppProductTypeField(
                        selectedType: _selectedType,
                        onTap: () async {
                          final selected = await AppProductTypeSelector.show(
                            context,
                            selectedType: _selectedType,
                          );
                          if (selected != null) {
                            setState(() {
                              _selectedType = selected;
                            });
                          }
                        },
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
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: AppPrimaryButton(
                text: 'Update Product',
                onPressed:
                    () => ProductFormHandler.handleEditProduct(
                      context: context,
                      ref: ref,
                      formKey: _formKey,
                      product: widget.product,
                      name: _nameController.text,
                      bestBefore: _selectedBestBefore,
                      type: _selectedType,
                    ),
                isLoading: editProductState.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
