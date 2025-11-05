import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';

class AppActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const AppActionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color:
                    isDestructive
                        ? AppColors.error.withValues(alpha: 0.1)
                        : AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isDestructive ? AppColors.error : AppColors.textPrimary,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:
                      isDestructive ? AppColors.error : AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
