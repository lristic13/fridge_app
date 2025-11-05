// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddProductState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;

  /// Create a copy of AddProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddProductStateCopyWith<AddProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddProductStateCopyWith<$Res> {
  factory $AddProductStateCopyWith(
    AddProductState value,
    $Res Function(AddProductState) then,
  ) = _$AddProductStateCopyWithImpl<$Res, AddProductState>;
  @useResult
  $Res call({bool isLoading, String? errorMessage, bool isSuccess});
}

/// @nodoc
class _$AddProductStateCopyWithImpl<$Res, $Val extends AddProductState>
    implements $AddProductStateCopyWith<$Res> {
  _$AddProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isSuccess = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
            isSuccess:
                null == isSuccess
                    ? _value.isSuccess
                    : isSuccess // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddProductStateImplCopyWith<$Res>
    implements $AddProductStateCopyWith<$Res> {
  factory _$$AddProductStateImplCopyWith(
    _$AddProductStateImpl value,
    $Res Function(_$AddProductStateImpl) then,
  ) = __$$AddProductStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? errorMessage, bool isSuccess});
}

/// @nodoc
class __$$AddProductStateImplCopyWithImpl<$Res>
    extends _$AddProductStateCopyWithImpl<$Res, _$AddProductStateImpl>
    implements _$$AddProductStateImplCopyWith<$Res> {
  __$$AddProductStateImplCopyWithImpl(
    _$AddProductStateImpl _value,
    $Res Function(_$AddProductStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isSuccess = null,
  }) {
    return _then(
      _$AddProductStateImpl(
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        isSuccess:
            null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$AddProductStateImpl implements _AddProductState {
  const _$AddProductStateImpl({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isSuccess;

  @override
  String toString() {
    return 'AddProductState(isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddProductStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, errorMessage, isSuccess);

  /// Create a copy of AddProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddProductStateImplCopyWith<_$AddProductStateImpl> get copyWith =>
      __$$AddProductStateImplCopyWithImpl<_$AddProductStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AddProductState implements AddProductState {
  const factory _AddProductState({
    final bool isLoading,
    final String? errorMessage,
    final bool isSuccess,
  }) = _$AddProductStateImpl;

  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  bool get isSuccess;

  /// Create a copy of AddProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddProductStateImplCopyWith<_$AddProductStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
