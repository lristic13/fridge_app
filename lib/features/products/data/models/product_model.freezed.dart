// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get fridgeId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get timeStored => throw _privateConstructorUsedError;
  DateTime get bestBefore => throw _privateConstructorUsedError;
  ProductType get type => throw _privateConstructorUsedError;

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
    ProductModel value,
    $Res Function(ProductModel) then,
  ) = _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    String fridgeId,
    String name,
    DateTime timeStored,
    DateTime bestBefore,
    ProductType type,
  });
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fridgeId = null,
    Object? name = null,
    Object? timeStored = null,
    Object? bestBefore = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            fridgeId:
                null == fridgeId
                    ? _value.fridgeId
                    : fridgeId // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            timeStored:
                null == timeStored
                    ? _value.timeStored
                    : timeStored // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            bestBefore:
                null == bestBefore
                    ? _value.bestBefore
                    : bestBefore // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ProductType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
    _$ProductModelImpl value,
    $Res Function(_$ProductModelImpl) then,
  ) = __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String fridgeId,
    String name,
    DateTime timeStored,
    DateTime bestBefore,
    ProductType type,
  });
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
    _$ProductModelImpl _value,
    $Res Function(_$ProductModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fridgeId = null,
    Object? name = null,
    Object? timeStored = null,
    Object? bestBefore = null,
    Object? type = null,
  }) {
    return _then(
      _$ProductModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        fridgeId:
            null == fridgeId
                ? _value.fridgeId
                : fridgeId // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        timeStored:
            null == timeStored
                ? _value.timeStored
                : timeStored // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        bestBefore:
            null == bestBefore
                ? _value.bestBefore
                : bestBefore // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ProductType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductModelImpl extends _ProductModel {
  const _$ProductModelImpl({
    required this.id,
    required this.userId,
    required this.fridgeId,
    required this.name,
    required this.timeStored,
    required this.bestBefore,
    required this.type,
  }) : super._();

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String fridgeId;
  @override
  final String name;
  @override
  final DateTime timeStored;
  @override
  final DateTime bestBefore;
  @override
  final ProductType type;

  @override
  String toString() {
    return 'ProductModel(id: $id, userId: $userId, fridgeId: $fridgeId, name: $name, timeStored: $timeStored, bestBefore: $bestBefore, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fridgeId, fridgeId) ||
                other.fridgeId == fridgeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.timeStored, timeStored) ||
                other.timeStored == timeStored) &&
            (identical(other.bestBefore, bestBefore) ||
                other.bestBefore == bestBefore) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    fridgeId,
    name,
    timeStored,
    bestBefore,
    type,
  );

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(this);
  }
}

abstract class _ProductModel extends ProductModel {
  const factory _ProductModel({
    required final String id,
    required final String userId,
    required final String fridgeId,
    required final String name,
    required final DateTime timeStored,
    required final DateTime bestBefore,
    required final ProductType type,
  }) = _$ProductModelImpl;
  const _ProductModel._() : super._();

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get fridgeId;
  @override
  String get name;
  @override
  DateTime get timeStored;
  @override
  DateTime get bestBefore;
  @override
  ProductType get type;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
