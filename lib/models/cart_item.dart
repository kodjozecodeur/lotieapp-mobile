import 'package:freezed_annotation/freezed_annotation.dart';
import 'menu_item.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

/// Cart Item Model
/// 
/// Represents an item in the shopping cart with all its details,
/// customizations, and calculated pricing.
@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required MenuItem menuItem,
    required int quantity,
    required Map<String, int> customizations, // supplement name -> quantity
    required double basePrice,
    required Map<String, double> customizationPrices, // supplement name -> price
    @Default(0.0) double totalPrice,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
}

/// Extension methods for CartItem
extension CartItemExtension on CartItem {
  /// Calculate the total price including customizations
  double get calculatedTotalPrice {
    double total = basePrice * quantity;
    
    customizations.forEach((supplement, supplementQuantity) {
      final supplementPrice = customizationPrices[supplement] ?? 0.0;
      total += supplementPrice * supplementQuantity;
    });
    
    return total;
  }
  
  /// Get total quantity including customizations
  int get totalQuantity {
    int total = quantity;
    total += customizations.values.fold(0, (sum, qty) => sum + qty);
    return total;
  }
  
  /// Get formatted price string
  String get formattedPrice => '${calculatedTotalPrice.toInt()} FCFA';
  
  /// Get customization summary
  String get customizationSummary {
    if (customizations.isEmpty) return '';
    
    final supplements = customizations.entries
        .where((entry) => entry.value > 0)
        .map((entry) => '${entry.key} (${entry.value})')
        .join(', ');
    
    return supplements.isNotEmpty ? '+ $supplements' : '';
  }
  
  /// Check if item has customizations
  bool get hasCustomizations => customizations.values.any((qty) => qty > 0);
}
