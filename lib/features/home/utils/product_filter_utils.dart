import 'package:fridge_app/features/home/models/product_sort_option.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';

class ProductFilterUtils {
  ProductFilterUtils._();

  static List<ProductModel> filterAndSort({
    required List<ProductModel> products,
    required String searchQuery,
    required Set<ProductType> selectedTypes,
    required ProductSortOption sortOption,
  }) {
    var filtered = products;

    if (searchQuery.isNotEmpty) {
      filtered =
          filtered
              .where(
                (product) => product.name.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
              )
              .toList();
    }

    if (selectedTypes.isNotEmpty) {
      filtered =
          filtered
              .where((product) => selectedTypes.contains(product.type))
              .toList();
    }

    filtered.sort((a, b) {
      switch (sortOption) {
        case ProductSortOption.timeStored:
          return b.timeStored.compareTo(a.timeStored);
        case ProductSortOption.bestBefore:
          return a.bestBefore.compareTo(b.bestBefore);
      }
    });

    return filtered;
  }
}
