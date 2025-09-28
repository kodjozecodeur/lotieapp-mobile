// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return _CartItem.fromJson(json);
}

/// @nodoc
mixin _$CartItem {
  String get id => throw _privateConstructorUsedError;
  MenuItem get menuItem => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  Map<String, int> get customizations =>
      throw _privateConstructorUsedError; // supplement name -> quantity
  double get basePrice => throw _privateConstructorUsedError;
  Map<String, double> get customizationPrices =>
      throw _privateConstructorUsedError; // supplement name -> price
  double get totalPrice => throw _privateConstructorUsedError;

  /// Serializes this CartItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartItemCopyWith<CartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) then) =
      _$CartItemCopyWithImpl<$Res, CartItem>;
  @useResult
  $Res call({
    String id,
    MenuItem menuItem,
    int quantity,
    Map<String, int> customizations,
    double basePrice,
    Map<String, double> customizationPrices,
    double totalPrice,
  });
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res, $Val extends CartItem>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? menuItem = null,
    Object? quantity = null,
    Object? customizations = null,
    Object? basePrice = null,
    Object? customizationPrices = null,
    Object? totalPrice = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            menuItem: null == menuItem
                ? _value.menuItem
                : menuItem // ignore: cast_nullable_to_non_nullable
                      as MenuItem,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            customizations: null == customizations
                ? _value.customizations
                : customizations // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            basePrice: null == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as double,
            customizationPrices: null == customizationPrices
                ? _value.customizationPrices
                : customizationPrices // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            totalPrice: null == totalPrice
                ? _value.totalPrice
                : totalPrice // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CartItemImplCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$$CartItemImplCopyWith(
    _$CartItemImpl value,
    $Res Function(_$CartItemImpl) then,
  ) = __$$CartItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    MenuItem menuItem,
    int quantity,
    Map<String, int> customizations,
    double basePrice,
    Map<String, double> customizationPrices,
    double totalPrice,
  });
}

/// @nodoc
class __$$CartItemImplCopyWithImpl<$Res>
    extends _$CartItemCopyWithImpl<$Res, _$CartItemImpl>
    implements _$$CartItemImplCopyWith<$Res> {
  __$$CartItemImplCopyWithImpl(
    _$CartItemImpl _value,
    $Res Function(_$CartItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? menuItem = null,
    Object? quantity = null,
    Object? customizations = null,
    Object? basePrice = null,
    Object? customizationPrices = null,
    Object? totalPrice = null,
  }) {
    return _then(
      _$CartItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        menuItem: null == menuItem
            ? _value.menuItem
            : menuItem // ignore: cast_nullable_to_non_nullable
                  as MenuItem,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        customizations: null == customizations
            ? _value._customizations
            : customizations // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        basePrice: null == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as double,
        customizationPrices: null == customizationPrices
            ? _value._customizationPrices
            : customizationPrices // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        totalPrice: null == totalPrice
            ? _value.totalPrice
            : totalPrice // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CartItemImpl implements _CartItem {
  const _$CartItemImpl({
    required this.id,
    required this.menuItem,
    required this.quantity,
    required final Map<String, int> customizations,
    required this.basePrice,
    required final Map<String, double> customizationPrices,
    this.totalPrice = 0.0,
  }) : _customizations = customizations,
       _customizationPrices = customizationPrices;

  factory _$CartItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartItemImplFromJson(json);

  @override
  final String id;
  @override
  final MenuItem menuItem;
  @override
  final int quantity;
  final Map<String, int> _customizations;
  @override
  Map<String, int> get customizations {
    if (_customizations is EqualUnmodifiableMapView) return _customizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customizations);
  }

  // supplement name -> quantity
  @override
  final double basePrice;
  final Map<String, double> _customizationPrices;
  @override
  Map<String, double> get customizationPrices {
    if (_customizationPrices is EqualUnmodifiableMapView)
      return _customizationPrices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customizationPrices);
  }

  // supplement name -> price
  @override
  @JsonKey()
  final double totalPrice;

  @override
  String toString() {
    return 'CartItem(id: $id, menuItem: $menuItem, quantity: $quantity, customizations: $customizations, basePrice: $basePrice, customizationPrices: $customizationPrices, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.menuItem, menuItem) ||
                other.menuItem == menuItem) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            const DeepCollectionEquality().equals(
              other._customizations,
              _customizations,
            ) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            const DeepCollectionEquality().equals(
              other._customizationPrices,
              _customizationPrices,
            ) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    menuItem,
    quantity,
    const DeepCollectionEquality().hash(_customizations),
    basePrice,
    const DeepCollectionEquality().hash(_customizationPrices),
    totalPrice,
  );

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      __$$CartItemImplCopyWithImpl<_$CartItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartItemImplToJson(this);
  }
}

abstract class _CartItem implements CartItem {
  const factory _CartItem({
    required final String id,
    required final MenuItem menuItem,
    required final int quantity,
    required final Map<String, int> customizations,
    required final double basePrice,
    required final Map<String, double> customizationPrices,
    final double totalPrice,
  }) = _$CartItemImpl;

  factory _CartItem.fromJson(Map<String, dynamic> json) =
      _$CartItemImpl.fromJson;

  @override
  String get id;
  @override
  MenuItem get menuItem;
  @override
  int get quantity;
  @override
  Map<String, int> get customizations; // supplement name -> quantity
  @override
  double get basePrice;
  @override
  Map<String, double> get customizationPrices; // supplement name -> price
  @override
  double get totalPrice;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
