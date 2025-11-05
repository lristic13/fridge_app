import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/utils/ui_helpers.dart';
import 'package:fridge_app/features/products/add/controllers/add_product_controller.dart';
import 'package:fridge_app/features/products/add/widgets/product_best_before_field.dart';
import 'package:fridge_app/features/products/add/widgets/product_name_field.dart';
import 'package:fridge_app/features/products/add/widgets/product_type_field.dart';
import 'package:fridge_app/features/products/add/widgets/product_type_selector.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';
import 'package:fridge_app/features/products/utils/date_picker_helper.dart';
import 'package:fridge_app/features/products/utils/product_form_handler.dart';
import 'package:fridge_app/widgets/app_primary_button.dart';
import 'package:go_router/go_router.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  final ProductModel? productToDuplicate;

  const AddProductScreen({super.key, this.productToDuplicate});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  ProductType? _selectedType;
  DateTime? _selectedBestBefore;

  @override
  void initState() {
    super.initState();
    if (widget.productToDuplicate != null) {
      _nameController.text = widget.productToDuplicate!.name;
      _selectedType = widget.productToDuplicate!.type;
      _selectedBestBefore = widget.productToDuplicate!.bestBefore;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addProductState = ref.watch(addProductControllerProvider);

    ref.listen(addProductControllerProvider, (previous, next) {
      if (next.errorMessage != null) {
        UiHelpers.showErrorSnackBar(context, next.errorMessage!);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.productToDuplicate != null
              ? 'Duplicate Product'
              : 'Add Product',
        ),
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
                          final now = DateTime.now();
                          final initialDate =
                              _selectedBestBefore ??
                              now.add(const Duration(days: 7));
                          final picked = await DatePickerHelper.show(
                            context: context,
                            initialDate: initialDate,
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
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: AppPrimaryButton(
                text: 'Save Product',
                onPressed:
                    () => ProductFormHandler.handleAddProduct(
                      context: context,
                      ref: ref,
                      formKey: _formKey,
                      name: _nameController.text,
                      bestBefore: _selectedBestBefore,
                      type: _selectedType,
                    ),
                isLoading: addProductState.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
