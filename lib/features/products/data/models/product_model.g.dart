// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      fridgeId: json['fridgeId'] as String,
      name: json['name'] as String,
      timeStored: DateTime.parse(json['timeStored'] as String),
      bestBefore: DateTime.parse(json['bestBefore'] as String),
      type: $enumDecode(_$ProductTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fridgeId': instance.fridgeId,
      'name': instance.name,
      'timeStored': instance.timeStored.toIso8601String(),
      'bestBefore': instance.bestBefore.toIso8601String(),
      'type': _$ProductTypeEnumMap[instance.type]!,
    };

const _$ProductTypeEnumMap = {
  ProductType.dairy: 'dairy',
  ProductType.meat: 'meat',
  ProductType.vegetables: 'vegetables',
  ProductType.fruits: 'fruits',
  ProductType.beverages: 'beverages',
  ProductType.sweets: 'sweets',
};
