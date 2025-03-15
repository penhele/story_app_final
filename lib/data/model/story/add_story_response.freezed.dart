// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_story_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AddStoryResponse _$AddStoryResponseFromJson(Map<String, dynamic> json) {
  return _AddStoryResponse.fromJson(json);
}

/// @nodoc
mixin _$AddStoryResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this AddStoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddStoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddStoryResponseCopyWith<AddStoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddStoryResponseCopyWith<$Res> {
  factory $AddStoryResponseCopyWith(
    AddStoryResponse value,
    $Res Function(AddStoryResponse) then,
  ) = _$AddStoryResponseCopyWithImpl<$Res, AddStoryResponse>;
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class _$AddStoryResponseCopyWithImpl<$Res, $Val extends AddStoryResponse>
    implements $AddStoryResponseCopyWith<$Res> {
  _$AddStoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddStoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? message = null}) {
    return _then(
      _value.copyWith(
            error:
                null == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as bool,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddStoryResponseImplCopyWith<$Res>
    implements $AddStoryResponseCopyWith<$Res> {
  factory _$$AddStoryResponseImplCopyWith(
    _$AddStoryResponseImpl value,
    $Res Function(_$AddStoryResponseImpl) then,
  ) = __$$AddStoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class __$$AddStoryResponseImplCopyWithImpl<$Res>
    extends _$AddStoryResponseCopyWithImpl<$Res, _$AddStoryResponseImpl>
    implements _$$AddStoryResponseImplCopyWith<$Res> {
  __$$AddStoryResponseImplCopyWithImpl(
    _$AddStoryResponseImpl _value,
    $Res Function(_$AddStoryResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddStoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? message = null}) {
    return _then(
      _$AddStoryResponseImpl(
        error:
            null == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as bool,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddStoryResponseImpl implements _AddStoryResponse {
  const _$AddStoryResponseImpl({required this.error, required this.message});

  factory _$AddStoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddStoryResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;

  @override
  String toString() {
    return 'AddStoryResponse(error: $error, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddStoryResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  /// Create a copy of AddStoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddStoryResponseImplCopyWith<_$AddStoryResponseImpl> get copyWith =>
      __$$AddStoryResponseImplCopyWithImpl<_$AddStoryResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AddStoryResponseImplToJson(this);
  }
}

abstract class _AddStoryResponse implements AddStoryResponse {
  const factory _AddStoryResponse({
    required final bool error,
    required final String message,
  }) = _$AddStoryResponseImpl;

  factory _AddStoryResponse.fromJson(Map<String, dynamic> json) =
      _$AddStoryResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;

  /// Create a copy of AddStoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddStoryResponseImplCopyWith<_$AddStoryResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
