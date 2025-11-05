import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:intl/intl.dart';

class AppProductBestBeforeField extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const AppProductBestBeforeField({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Best Before Date',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? DateFormat('MMM dd, yyyy').format(selectedDate!)
                        : 'Select date',
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          selectedDate != null
                              ? AppColors.textPrimary
                              : AppColors.textHint,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
