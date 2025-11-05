import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const AppSearchBar({
    super.key,
    required this.controller,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          suffixIcon:
              searchQuery.isNotEmpty
                  ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: onClear,
                  )
                  : null,
          filled: true,
          fillColor: AppColors.surface,
          hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
