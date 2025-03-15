// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoryListResponse _$StoryListResponseFromJson(Map<String, dynamic> json) {
  return _StoryListResponse.fromJson(json);
}

/// @nodoc
mixin _$StoryListResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: "listStory")
  List<Story> get stories => throw _privateConstructorUsedError;

  /// Serializes this StoryListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryListResponseCopyWith<StoryListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryListResponseCopyWith<$Res> {
  factory $StoryListResponseCopyWith(
    StoryListResponse value,
    $Res Function(StoryListResponse) then,
  ) = _$StoryListResponseCopyWithImpl<$Res, StoryListResponse>;
  @useResult
  $Res call({
    bool error,
    String message,
    @JsonKey(name: "listStory") List<Story> stories,
  });
}

/// @nodoc
class _$StoryListResponseCopyWithImpl<$Res, $Val extends StoryListResponse>
    implements $StoryListResponseCopyWith<$Res> {
  _$StoryListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? stories = null,
  }) {
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
            stories:
                null == stories
                    ? _value.stories
                    : stories // ignore: cast_nullable_to_non_nullable
                        as List<Story>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryListResponseImplCopyWith<$Res>
    implements $StoryListResponseCopyWith<$Res> {
  factory _$$StoryListResponseImplCopyWith(
    _$StoryListResponseImpl value,
    $Res Function(_$StoryListResponseImpl) then,
  ) = __$$StoryListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool error,
    String message,
    @JsonKey(name: "listStory") List<Story> stories,
  });
}

/// @nodoc
class __$$StoryListResponseImplCopyWithImpl<$Res>
    extends _$StoryListResponseCopyWithImpl<$Res, _$StoryListResponseImpl>
    implements _$$StoryListResponseImplCopyWith<$Res> {
  __$$StoryListResponseImplCopyWithImpl(
    _$StoryListResponseImpl _value,
    $Res Function(_$StoryListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? stories = null,
  }) {
    return _then(
      _$StoryListResponseImpl(
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
        stories:
            null == stories
                ? _value._stories
                : stories // ignore: cast_nullable_to_non_nullable
                    as List<Story>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryListResponseImpl implements _StoryListResponse {
  const _$StoryListResponseImpl({
    required this.error,
    required this.message,
    @JsonKey(name: "listStory") required final List<Story> stories,
  }) : _stories = stories;

  factory _$StoryListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryListResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  final List<Story> _stories;
  @override
  @JsonKey(name: "listStory")
  List<Story> get stories {
    if (_stories is EqualUnmodifiableListView) return _stories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stories);
  }

  @override
  String toString() {
    return 'StoryListResponse(error: $error, message: $message, stories: $stories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryListResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._stories, _stories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    error,
    message,
    const DeepCollectionEquality().hash(_stories),
  );

  /// Create a copy of StoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryListResponseImplCopyWith<_$StoryListResponseImpl> get copyWith =>
      __$$StoryListResponseImplCopyWithImpl<_$StoryListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryListResponseImplToJson(this);
  }
}

abstract class _StoryListResponse implements StoryListResponse {
  const factory _StoryListResponse({
    required final bool error,
    required final String message,
    @JsonKey(name: "listStory") required final List<Story> stories,
  }) = _$StoryListResponseImpl;

  factory _StoryListResponse.fromJson(Map<String, dynamic> json) =
      _$StoryListResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(name: "listStory")
  List<Story> get stories;

  /// Create a copy of StoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryListResponseImplCopyWith<_$StoryListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
