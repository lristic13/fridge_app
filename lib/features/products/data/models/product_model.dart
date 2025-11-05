import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fridge_app/core/constants/app_colors.dart';
import 'package:fridge_app/features/products/data/models/product_type.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required String id,
    required String userId,
    required String fridgeId,
    required String name,
    required DateTime timeStored,
    required DateTime bestBefore,
    required ProductType type,
  }) = _ProductModel;

  int get daysUntilExpiry {
    final now = DateTime.now();
    final difference = bestBefore.difference(now);
    return difference.inDays;
  }

  bool get isExpired => daysUntilExpiry < 0;

  bool get isExpiringSoon => daysUntilExpiry >= 0 && daysUntilExpiry <= 3;

  Color get expiryColor {
    if (isExpired) {
      return AppColors.error;
    } else if (isExpiringSoon) {
      return AppColors.warning;
    }
    return AppColors.success;
  }

  String get expiryText {
    if (isExpired) {
      final daysExpired = daysUntilExpiry.abs();
      return 'Expired $daysExpired ${daysExpired == 1 ? 'day' : 'days'} ago';
    } else if (daysUntilExpiry == 0) {
      return 'Expires soon';
    } else {
      final days = daysUntilExpiry;
      return '$days ${days == 1 ? 'day' : 'days'} left';
    }
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'fridgeId': fridgeId,
      'name': name,
      'timeStored': Timestamp.fromDate(timeStored),
      'bestBefore': Timestamp.fromDate(bestBefore),
      'type': type.name,
    };
  }

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      userId: data['userId'] as String,
      fridgeId: data['fridgeId'] as String,
      name: data['name'] as String,
      timeStored: (data['timeStored'] as Timestamp).toDate(),
      bestBefore: (data['bestBefore'] as Timestamp).toDate(),
      type: ProductType.fromString(data['type'] as String),
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
