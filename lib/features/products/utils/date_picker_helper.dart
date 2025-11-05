import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/app_colors.dart';

class DatePickerHelper {
  DatePickerHelper._();

  static Future<DateTime?> show({
    required BuildContext context,
    required DateTime initialDate,
  }) async {
    if (Platform.isIOS) {
      return await _showCupertinoDatePicker(
        context: context,
        initialDate: initialDate,
      );
    } else {
      return await _showMaterialDatePicker(
        context: context,
        initialDate: initialDate,
      );
    }
  }

  static Future<DateTime?> _showMaterialDatePicker({
    required BuildContext context,
    required DateTime initialDate,
  }) async {
    final now = DateTime.now();
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  static Future<DateTime?> _showCupertinoDatePicker({
    required BuildContext context,
    required DateTime initialDate,
  }) async {
    DateTime? selectedDate;
    final now = DateTime.now();

    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        DateTime tempDate = initialDate;

        return Container(
          height: 250,
          color: AppColors.surface,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () {
                      selectedDate = tempDate;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  minimumDate: DateTime(now.year - 1),
                  maximumDate: DateTime(now.year + 2, 12, 31),
                  onDateTimeChanged: (date) {
                    tempDate = date;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    return selectedDate;
  }
}
