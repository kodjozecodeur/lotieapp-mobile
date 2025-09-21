// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _ApiResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ApiResponse<T> {
  bool get success => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  ApiError? get error => throw _privateConstructorUsedError;
  ApiMeta? get meta => throw _privateConstructorUsedError;

  /// Serializes this ApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseCopyWith<T, ApiResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(
    ApiResponse<T> value,
    $Res Function(ApiResponse<T>) then,
  ) = _$ApiResponseCopyWithImpl<T, $Res, ApiResponse<T>>;
  @useResult
  $Res call({
    bool success,
    T? data,
    String? message,
    ApiError? error,
    ApiMeta? meta,
  });

  $ApiErrorCopyWith<$Res>? get error;
  $ApiMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res, $Val extends ApiResponse<T>>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
    Object? meta = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as T?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as ApiError?,
            meta: freezed == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as ApiMeta?,
          )
          as $Val,
    );
  }

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $ApiErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiMetaCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $ApiMetaCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiResponseImplCopyWith<T, $Res>
    implements $ApiResponseCopyWith<T, $Res> {
  factory _$$ApiResponseImplCopyWith(
    _$ApiResponseImpl<T> value,
    $Res Function(_$ApiResponseImpl<T>) then,
  ) = __$$ApiResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    bool success,
    T? data,
    String? message,
    ApiError? error,
    ApiMeta? meta,
  });

  @override
  $ApiErrorCopyWith<$Res>? get error;
  @override
  $ApiMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$ApiResponseImplCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseImpl<T>>
    implements _$$ApiResponseImplCopyWith<T, $Res> {
  __$$ApiResponseImplCopyWithImpl(
    _$ApiResponseImpl<T> _value,
    $Res Function(_$ApiResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
    Object? meta = freezed,
  }) {
    return _then(
      _$ApiResponseImpl<T>(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as ApiError?,
        meta: freezed == meta
            ? _value.meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as ApiMeta?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ApiResponseImpl<T> implements _ApiResponse<T> {
  const _$ApiResponseImpl({
    required this.success,
    this.data,
    this.message,
    this.error,
    this.meta,
  });

  factory _$ApiResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$ApiResponseImplFromJson(json, fromJsonT);

  @override
  final bool success;
  @override
  final T? data;
  @override
  final String? message;
  @override
  final ApiError? error;
  @override
  final ApiMeta? meta;

  @override
  String toString() {
    return 'ApiResponse<$T>(success: $success, data: $data, message: $message, error: $error, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseImpl<T> &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    const DeepCollectionEquality().hash(data),
    message,
    error,
    meta,
  );

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseImplCopyWith<T, _$ApiResponseImpl<T>> get copyWith =>
      __$$ApiResponseImplCopyWithImpl<T, _$ApiResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ApiResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _ApiResponse<T> implements ApiResponse<T> {
  const factory _ApiResponse({
    required final bool success,
    final T? data,
    final String? message,
    final ApiError? error,
    final ApiMeta? meta,
  }) = _$ApiResponseImpl<T>;

  factory _ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$ApiResponseImpl<T>.fromJson;

  @override
  bool get success;
  @override
  T? get data;
  @override
  String? get message;
  @override
  ApiError? get error;
  @override
  ApiMeta? get meta;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseImplCopyWith<T, _$ApiResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  return _ApiError.fromJson(json);
}

/// @nodoc
mixin _$ApiError {
  String get message => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  Map<String, dynamic>? get details => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  String? get field => throw _privateConstructorUsedError;

  /// Serializes this ApiError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiErrorCopyWith<ApiError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorCopyWith<$Res> {
  factory $ApiErrorCopyWith(ApiError value, $Res Function(ApiError) then) =
      _$ApiErrorCopyWithImpl<$Res, ApiError>;
  @useResult
  $Res call({
    String message,
    String? code,
    Map<String, dynamic>? details,
    int? statusCode,
    String? field,
  });
}

/// @nodoc
class _$ApiErrorCopyWithImpl<$Res, $Val extends ApiError>
    implements $ApiErrorCopyWith<$Res> {
  _$ApiErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? details = freezed,
    Object? statusCode = freezed,
    Object? field = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String?,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as int?,
            field: freezed == field
                ? _value.field
                : field // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiErrorImplCopyWith<$Res>
    implements $ApiErrorCopyWith<$Res> {
  factory _$$ApiErrorImplCopyWith(
    _$ApiErrorImpl value,
    $Res Function(_$ApiErrorImpl) then,
  ) = __$$ApiErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    String? code,
    Map<String, dynamic>? details,
    int? statusCode,
    String? field,
  });
}

/// @nodoc
class __$$ApiErrorImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$ApiErrorImpl>
    implements _$$ApiErrorImplCopyWith<$Res> {
  __$$ApiErrorImplCopyWithImpl(
    _$ApiErrorImpl _value,
    $Res Function(_$ApiErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? details = freezed,
    Object? statusCode = freezed,
    Object? field = freezed,
  }) {
    return _then(
      _$ApiErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        details: freezed == details
            ? _value._details
            : details // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        field: freezed == field
            ? _value.field
            : field // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiErrorImpl implements _ApiError {
  const _$ApiErrorImpl({
    required this.message,
    this.code,
    final Map<String, dynamic>? details,
    this.statusCode,
    this.field,
  }) : _details = details;

  factory _$ApiErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiErrorImplFromJson(json);

  @override
  final String message;
  @override
  final String? code;
  final Map<String, dynamic>? _details;
  @override
  Map<String, dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? statusCode;
  @override
  final String? field;

  @override
  String toString() {
    return 'ApiError(message: $message, code: $code, details: $details, statusCode: $statusCode, field: $field)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.field, field) || other.field == field));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    code,
    const DeepCollectionEquality().hash(_details),
    statusCode,
    field,
  );

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiErrorImplCopyWith<_$ApiErrorImpl> get copyWith =>
      __$$ApiErrorImplCopyWithImpl<_$ApiErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiErrorImplToJson(this);
  }
}

abstract class _ApiError implements ApiError {
  const factory _ApiError({
    required final String message,
    final String? code,
    final Map<String, dynamic>? details,
    final int? statusCode,
    final String? field,
  }) = _$ApiErrorImpl;

  factory _ApiError.fromJson(Map<String, dynamic> json) =
      _$ApiErrorImpl.fromJson;

  @override
  String get message;
  @override
  String? get code;
  @override
  Map<String, dynamic>? get details;
  @override
  int? get statusCode;
  @override
  String? get field;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiErrorImplCopyWith<_$ApiErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiMeta _$ApiMetaFromJson(Map<String, dynamic> json) {
  return _ApiMeta.fromJson(json);
}

/// @nodoc
mixin _$ApiMeta {
  String? get timestamp => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;
  int? get totalCount => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;
  bool? get hasMore => throw _privateConstructorUsedError;
  Map<String, dynamic>? get extra => throw _privateConstructorUsedError;

  /// Serializes this ApiMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiMetaCopyWith<ApiMeta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiMetaCopyWith<$Res> {
  factory $ApiMetaCopyWith(ApiMeta value, $Res Function(ApiMeta) then) =
      _$ApiMetaCopyWithImpl<$Res, ApiMeta>;
  @useResult
  $Res call({
    String? timestamp,
    String? requestId,
    int? totalCount,
    int? page,
    int? pageSize,
    bool? hasMore,
    Map<String, dynamic>? extra,
  });
}

/// @nodoc
class _$ApiMetaCopyWithImpl<$Res, $Val extends ApiMeta>
    implements $ApiMetaCopyWith<$Res> {
  _$ApiMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = freezed,
    Object? requestId = freezed,
    Object? totalCount = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? hasMore = freezed,
    Object? extra = freezed,
  }) {
    return _then(
      _value.copyWith(
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String?,
            requestId: freezed == requestId
                ? _value.requestId
                : requestId // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalCount: freezed == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            page: freezed == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int?,
            pageSize: freezed == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int?,
            hasMore: freezed == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool?,
            extra: freezed == extra
                ? _value.extra
                : extra // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiMetaImplCopyWith<$Res> implements $ApiMetaCopyWith<$Res> {
  factory _$$ApiMetaImplCopyWith(
    _$ApiMetaImpl value,
    $Res Function(_$ApiMetaImpl) then,
  ) = __$$ApiMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? timestamp,
    String? requestId,
    int? totalCount,
    int? page,
    int? pageSize,
    bool? hasMore,
    Map<String, dynamic>? extra,
  });
}

/// @nodoc
class __$$ApiMetaImplCopyWithImpl<$Res>
    extends _$ApiMetaCopyWithImpl<$Res, _$ApiMetaImpl>
    implements _$$ApiMetaImplCopyWith<$Res> {
  __$$ApiMetaImplCopyWithImpl(
    _$ApiMetaImpl _value,
    $Res Function(_$ApiMetaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = freezed,
    Object? requestId = freezed,
    Object? totalCount = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? hasMore = freezed,
    Object? extra = freezed,
  }) {
    return _then(
      _$ApiMetaImpl(
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String?,
        requestId: freezed == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalCount: freezed == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        page: freezed == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int?,
        pageSize: freezed == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int?,
        hasMore: freezed == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool?,
        extra: freezed == extra
            ? _value._extra
            : extra // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiMetaImpl implements _ApiMeta {
  const _$ApiMetaImpl({
    this.timestamp,
    this.requestId,
    this.totalCount,
    this.page,
    this.pageSize,
    this.hasMore,
    final Map<String, dynamic>? extra,
  }) : _extra = extra;

  factory _$ApiMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiMetaImplFromJson(json);

  @override
  final String? timestamp;
  @override
  final String? requestId;
  @override
  final int? totalCount;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final bool? hasMore;
  final Map<String, dynamic>? _extra;
  @override
  Map<String, dynamic>? get extra {
    final value = _extra;
    if (value == null) return null;
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ApiMeta(timestamp: $timestamp, requestId: $requestId, totalCount: $totalCount, page: $page, pageSize: $pageSize, hasMore: $hasMore, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiMetaImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            const DeepCollectionEquality().equals(other._extra, _extra));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    timestamp,
    requestId,
    totalCount,
    page,
    pageSize,
    hasMore,
    const DeepCollectionEquality().hash(_extra),
  );

  /// Create a copy of ApiMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiMetaImplCopyWith<_$ApiMetaImpl> get copyWith =>
      __$$ApiMetaImplCopyWithImpl<_$ApiMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiMetaImplToJson(this);
  }
}

abstract class _ApiMeta implements ApiMeta {
  const factory _ApiMeta({
    final String? timestamp,
    final String? requestId,
    final int? totalCount,
    final int? page,
    final int? pageSize,
    final bool? hasMore,
    final Map<String, dynamic>? extra,
  }) = _$ApiMetaImpl;

  factory _ApiMeta.fromJson(Map<String, dynamic> json) = _$ApiMetaImpl.fromJson;

  @override
  String? get timestamp;
  @override
  String? get requestId;
  @override
  int? get totalCount;
  @override
  int? get page;
  @override
  int? get pageSize;
  @override
  bool? get hasMore;
  @override
  Map<String, dynamic>? get extra;

  /// Create a copy of ApiMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiMetaImplCopyWith<_$ApiMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) {
  return _AuthResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthResponse {
  String get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  Map<String, dynamic> get user => throw _privateConstructorUsedError;
  String? get tokenType => throw _privateConstructorUsedError;
  int? get expiresIn => throw _privateConstructorUsedError;

  /// Serializes this AuthResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthResponseCopyWith<AuthResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResponseCopyWith<$Res> {
  factory $AuthResponseCopyWith(
    AuthResponse value,
    $Res Function(AuthResponse) then,
  ) = _$AuthResponseCopyWithImpl<$Res, AuthResponse>;
  @useResult
  $Res call({
    String accessToken,
    String? refreshToken,
    Map<String, dynamic> user,
    String? tokenType,
    int? expiresIn,
  });
}

/// @nodoc
class _$AuthResponseCopyWithImpl<$Res, $Val extends AuthResponse>
    implements $AuthResponseCopyWith<$Res> {
  _$AuthResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = freezed,
    Object? user = null,
    Object? tokenType = freezed,
    Object? expiresIn = freezed,
  }) {
    return _then(
      _value.copyWith(
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: freezed == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            tokenType: freezed == tokenType
                ? _value.tokenType
                : tokenType // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresIn: freezed == expiresIn
                ? _value.expiresIn
                : expiresIn // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthResponseImplCopyWith<$Res>
    implements $AuthResponseCopyWith<$Res> {
  factory _$$AuthResponseImplCopyWith(
    _$AuthResponseImpl value,
    $Res Function(_$AuthResponseImpl) then,
  ) = __$$AuthResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accessToken,
    String? refreshToken,
    Map<String, dynamic> user,
    String? tokenType,
    int? expiresIn,
  });
}

/// @nodoc
class __$$AuthResponseImplCopyWithImpl<$Res>
    extends _$AuthResponseCopyWithImpl<$Res, _$AuthResponseImpl>
    implements _$$AuthResponseImplCopyWith<$Res> {
  __$$AuthResponseImplCopyWithImpl(
    _$AuthResponseImpl _value,
    $Res Function(_$AuthResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = freezed,
    Object? user = null,
    Object? tokenType = freezed,
    Object? expiresIn = freezed,
  }) {
    return _then(
      _$AuthResponseImpl(
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: freezed == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        user: null == user
            ? _value._user
            : user // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        tokenType: freezed == tokenType
            ? _value.tokenType
            : tokenType // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresIn: freezed == expiresIn
            ? _value.expiresIn
            : expiresIn // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthResponseImpl implements _AuthResponse {
  const _$AuthResponseImpl({
    required this.accessToken,
    this.refreshToken,
    required final Map<String, dynamic> user,
    this.tokenType,
    this.expiresIn,
  }) : _user = user;

  factory _$AuthResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthResponseImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String? refreshToken;
  final Map<String, dynamic> _user;
  @override
  Map<String, dynamic> get user {
    if (_user is EqualUnmodifiableMapView) return _user;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_user);
  }

  @override
  final String? tokenType;
  @override
  final int? expiresIn;

  @override
  String toString() {
    return 'AuthResponse(accessToken: $accessToken, refreshToken: $refreshToken, user: $user, tokenType: $tokenType, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthResponseImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            const DeepCollectionEquality().equals(other._user, _user) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    accessToken,
    refreshToken,
    const DeepCollectionEquality().hash(_user),
    tokenType,
    expiresIn,
  );

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthResponseImplCopyWith<_$AuthResponseImpl> get copyWith =>
      __$$AuthResponseImplCopyWithImpl<_$AuthResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthResponseImplToJson(this);
  }
}

abstract class _AuthResponse implements AuthResponse {
  const factory _AuthResponse({
    required final String accessToken,
    final String? refreshToken,
    required final Map<String, dynamic> user,
    final String? tokenType,
    final int? expiresIn,
  }) = _$AuthResponseImpl;

  factory _AuthResponse.fromJson(Map<String, dynamic> json) =
      _$AuthResponseImpl.fromJson;

  @override
  String get accessToken;
  @override
  String? get refreshToken;
  @override
  Map<String, dynamic> get user;
  @override
  String? get tokenType;
  @override
  int? get expiresIn;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthResponseImplCopyWith<_$AuthResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
