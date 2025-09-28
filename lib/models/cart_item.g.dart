// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartItemImpl _$$CartItemImplFromJson(Map<String, dynamic> json) =>
    _$CartItemImpl(
      id: json['id'] as String,
      menuItem: MenuItem.fromJson(json['menuItem'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
      customizations: Map<String, int>.from(json['customizations'] as Map),
      basePrice: (json['basePrice'] as num).toDouble(),
      customizationPrices: (json['customizationPrices'] as Map<String, dynamic>)
          .map((k, e) => MapEntry(k, (e as num).toDouble())),
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$CartItemImplToJson(_$CartItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'menuItem': instance.menuItem,
      'quantity': instance.quantity,
      'customizations': instance.customizations,
      'basePrice': instance.basePrice,
      'customizationPrices': instance.customizationPrices,
      'totalPrice': instance.totalPrice,
    };
