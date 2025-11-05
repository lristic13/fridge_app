import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fridge_model.freezed.dart';
part 'fridge_model.g.dart';

@freezed
class FridgeModel with _$FridgeModel {
  const FridgeModel._();

  const factory FridgeModel({
    required String id,
    required String name,
    required String ownerId,
    required List<String> memberIds,
    required DateTime createdAt,
  }) = _FridgeModel;

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'ownerId': ownerId,
      'memberIds': memberIds,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory FridgeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FridgeModel(
      id: doc.id,
      name: data['name'] as String,
      ownerId: data['ownerId'] as String,
      memberIds: List<String>.from(data['memberIds'] as List),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  factory FridgeModel.fromJson(Map<String, dynamic> json) =>
      _$FridgeModelFromJson(json);
}
