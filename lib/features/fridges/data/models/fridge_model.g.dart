// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fridge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FridgeModelImpl _$$FridgeModelImplFromJson(Map<String, dynamic> json) =>
    _$FridgeModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerId: json['ownerId'] as String,
      memberIds:
          (json['memberIds'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FridgeModelImplToJson(_$FridgeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ownerId': instance.ownerId,
      'memberIds': instance.memberIds,
      'createdAt': instance.createdAt.toIso8601String(),
    };
