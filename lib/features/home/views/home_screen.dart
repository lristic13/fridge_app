import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/core/constants/app_strings.dart';
import 'package:fridge_app/core/providers/product_provider.dart';
import 'package:fridge_app/core/providers/selected_fridge_provider.dart';
import 'package:fridge_app/core/router/app_routes.dart';
import 'package:fridge_app/features/home/models/product_sort_option.dart';
import 'package:fridge_app/features/home/utils/product_action_handler.dart';
import 'package:fridge_app/features/home/utils/product_filter_utils.dart';
import 'package:fridge_app/features/home/widgets/app_empty_products_placeholder.dart';
import 'package:fridge_app/features/home/widgets/app_no_results_found.dart';
import 'package:fridge_app/features/home/widgets/app_product_type_chips.dart';
import 'package:fridge_app/features/home/widgets/app_products_list.dart';
import 'package:fridge_app/features/home/widgets/app_search_bar.dart';
import 'package:fridge_app/features/home/widgets/app_sort_chip.dart';
import 'package:fridge_app/features/home/widgets/app_product_sort_selector.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';
import 'package:fridge_app/widgets/shimmer/product_shimmer.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  ProductSortOption _sortOption = ProductSortOption.timeStored;
  Set<ProductType> _selectedTypes = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsyncValue = ref.watch(userProductsProvider);
    final selectedFridge = ref.watch(selectedFridgeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(selectedFridge?.name ?? AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push(AppRoutes.settings);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppSearchBar(
              controller: _searchController,
              searchQuery: _searchQuery,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              onClear: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
            ),

            AppProductTypeChips(
              selectedTypes: _selectedTypes,
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedTypes = newSelection;
                });
              },
            ),
            const SizedBox(height: 8),
            AppSortChip(
              sortOption: _sortOption,
              onTap: () async {
                final selected = await showModalBottomSheet<ProductSortOption>(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder:
                      (context) => AppProductSortBottomSheet(
                        selectedOption: _sortOption,
                      ),
                );
                if (selected != null) {
                  setState(() {
                    _sortOption = selected;
                  });
                }
              },
            ),
            Expanded(
              child: productsAsyncValue.when(
                data: (products) {
                  final filteredProducts = ProductFilterUtils.filterAndSort(
                    products: products,
                    searchQuery: _searchQuery,
                    selectedTypes: _selectedTypes,
                    sortOption: _sortOption,
                  );

                  if (filteredProducts.isEmpty) {
                    if (_searchQuery.isNotEmpty || _selectedTypes.isNotEmpty) {
                      String title;
                      String subtitle;

                      if (_searchQuery.isNotEmpty &&
                          _selectedTypes.isNotEmpty) {
                        title = 'No products found';
                        subtitle = 'Try different search terms or filters';
                      } else if (_searchQuery.isNotEmpty) {
                        title = 'No products found';
                        subtitle = 'Try searching with a different name';
                      } else {
                        title = 'No products found';
                        subtitle = 'No products of selected type';
                      }

                      return AppNoResultsFound(
                        title: title,
                        subtitle: subtitle,
                      );
                    }
                    return const AppEmptyProductsPlaceholder();
                  }

                  return AppProductsList(
                    products: filteredProducts,
                    onProductAction:
                        (product) => ProductActionHandler.handleProductAction(
                          context: context,
                          product: product,
                          ref: ref,
                        ),
                  );
                },
                loading: () => const AppProductShimmer(),
                error:
                    (error, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: AppColors.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppStrings.errorFailedToLoadProducts,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.addProduct);
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
