import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/selected_fridge_provider.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:fridge_app/features/products/data/repositories/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final userProductsProvider = StreamProvider<List<ProductModel>>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  final selectedFridge = ref.watch(selectedFridgeProvider);

  if (selectedFridge == null) {
    return Stream.value([]);
  }

  return productRepository.getFridgeProducts(selectedFridge.id).asyncMap((
    data,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return data;
  });
});
