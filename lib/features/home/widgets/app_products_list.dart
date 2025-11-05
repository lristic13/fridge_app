import 'package:flutter/material.dart';
import 'package:fridge_app/features/home/widgets/app_product_list_item.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';

/// Products list widget
class AppProductsList extends StatelessWidget {
  final List<ProductModel> products;
  final Function(ProductModel) onProductAction;

  const AppProductsList({
    super.key,
    required this.products,
    required this.onProductAction,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return AppProductListItem(
          product: product,
          onActionTap: () => onProductAction(product),
        );
      },
    );
  }
}
