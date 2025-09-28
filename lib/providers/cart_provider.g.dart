// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartStateImpl _$$CartStateImplFromJson(Map<String, dynamic> json) =>
    _$CartStateImpl(
      items:
          (json['items'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, CartItem.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      totalItems: (json['totalItems'] as num?)?.toInt() ?? 0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$CartStateImplToJson(_$CartStateImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'totalItems': instance.totalItems,
      'totalPrice': instance.totalPrice,
      'isLoading': instance.isLoading,
      'error': instance.error,
    };
