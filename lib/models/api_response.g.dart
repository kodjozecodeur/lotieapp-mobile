// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl<T> _$$ApiResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$ApiResponseImpl<T>(
  success: json['success'] as bool,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  message: json['message'] as String?,
  error: json['error'] == null
      ? null
      : ApiError.fromJson(json['error'] as Map<String, dynamic>),
  meta: json['meta'] == null
      ? null
      : ApiMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ApiResponseImplToJson<T>(
  _$ApiResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'message': instance.message,
  'error': instance.error,
  'meta': instance.meta,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_$ApiErrorImpl _$$ApiErrorImplFromJson(Map<String, dynamic> json) =>
    _$ApiErrorImpl(
      message: json['message'] as String,
      code: json['code'] as String?,
      details: json['details'] as Map<String, dynamic>?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      field: json['field'] as String?,
    );

Map<String, dynamic> _$$ApiErrorImplToJson(_$ApiErrorImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'details': instance.details,
      'statusCode': instance.statusCode,
      'field': instance.field,
    };

_$ApiMetaImpl _$$ApiMetaImplFromJson(Map<String, dynamic> json) =>
    _$ApiMetaImpl(
      timestamp: json['timestamp'] as String?,
      requestId: json['requestId'] as String?,
      totalCount: (json['totalCount'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      hasMore: json['hasMore'] as bool?,
      extra: json['extra'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ApiMetaImplToJson(_$ApiMetaImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'requestId': instance.requestId,
      'totalCount': instance.totalCount,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'hasMore': instance.hasMore,
      'extra': instance.extra,
    };

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] as Map<String, dynamic>,
      tokenType: json['tokenType'] as String?,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
    };
