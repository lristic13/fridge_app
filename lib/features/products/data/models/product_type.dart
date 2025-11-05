import 'package:flutter/material.dart';

enum ProductType {
  dairy,
  meat,
  vegetables,
  fruits,
  beverages,
  sweets;

  String get displayName {
    switch (this) {
      case ProductType.dairy:
        return 'Dairy';
      case ProductType.meat:
        return 'Meat';
      case ProductType.vegetables:
        return 'Vegetables';
      case ProductType.fruits:
        return 'Fruits';
      case ProductType.beverages:
        return 'Beverages';
      case ProductType.sweets:
        return 'Sweets';
    }
  }

  IconData get icon {
    switch (this) {
      case ProductType.dairy:
        return Icons.local_drink_outlined;
      case ProductType.meat:
        return Icons.set_meal_outlined;
      case ProductType.vegetables:
        return Icons.eco_outlined;
      case ProductType.fruits:
        return Icons.apple_outlined;
      case ProductType.beverages:
        return Icons.local_cafe_outlined;
      case ProductType.sweets:
        return Icons.cake_outlined;
    }
  }

  static ProductType fromString(String value) {
    return ProductType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => ProductType.dairy,
    );
  }
}
