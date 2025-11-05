import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class AppProductShimmer extends StatelessWidget {
  final int itemCount;

  const AppProductShimmer({super.key, this.itemCount = 10});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: AppColors.border,
                highlightColor: AppColors.surface,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: AppColors.border,
                      highlightColor: AppColors.surface,
                      child: Container(
                        height: 16,
                        width: 150,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: AppColors.border,
                      highlightColor: AppColors.surface,
                      child: Container(
                        height: 14,
                        width: 70,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Shimmer.fromColors(
                      baseColor: AppColors.border,
                      highlightColor: AppColors.surface,
                      child: Container(
                        height: 12,
                        width: 120,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
