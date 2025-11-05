enum ProductSortOption {
  timeStored,
  bestBefore;

  String get displayName {
    switch (this) {
      case ProductSortOption.timeStored:
        return 'Recently Added';
      case ProductSortOption.bestBefore:
        return 'Expiring Soon';
    }
  }

  String get description {
    switch (this) {
      case ProductSortOption.timeStored:
        return 'Sort by when the product was added';
      case ProductSortOption.bestBefore:
        return 'Sort by expiration date';
    }
  }
}
