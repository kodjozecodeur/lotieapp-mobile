import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/cart_item.dart';
import '../models/menu_item.dart';
import '../services/cart_persistence_service.dart';

part 'cart_provider.freezed.dart';
part 'cart_provider.g.dart';

/// Cart State Model
/// 
/// Contains the complete cart state with items and calculated totals.
@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default({}) Map<String, CartItem> items,
    @Default(0) int totalItems,
    @Default(0.0) double totalPrice,
    @Default(false) bool isLoading,
    String? error,
  }) = _CartState;

  factory CartState.fromJson(Map<String, dynamic> json) => _$CartStateFromJson(json);
}

/// Cart Notifier
/// 
/// Manages all cart operations with real-time state updates.
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState()) {
    _loadCartFromStorage();
  }

  /// Load cart from local storage on initialization
  Future<void> _loadCartFromStorage() async {
    setLoading(true);
    try {
      final savedCart = await CartPersistenceService.loadCartState();
      if (savedCart != null) {
        state = savedCart;
        _calculateTotals();
      }
    } catch (e) {
      setError('Failed to load cart: $e');
    } finally {
      setLoading(false);
    }
  }

  /// Save cart to local storage
  Future<void> _saveCartToStorage() async {
    try {
      await CartPersistenceService.saveCartState(state);
    } catch (e) {
      print('[CartNotifier] Error saving cart: $e');
    }
  }

  /// Add item to cart with customizations
  void addItem({
    required MenuItem menuItem,
    required Map<String, int> customizations,
    required double basePrice,
    required Map<String, double> customizationPrices,
  }) {
    final cartItemId = _generateCartItemId(menuItem.id, customizations);
    
    if (state.items.containsKey(cartItemId)) {
      // Item already exists, increment quantity
      updateQuantity(cartItemId, state.items[cartItemId]!.quantity + 1);
    } else {
      // New item, add to cart
      final cartItem = CartItem(
        id: cartItemId,
        menuItem: menuItem,
        quantity: 1,
        customizations: customizations,
        basePrice: basePrice,
        customizationPrices: customizationPrices,
      );
      
      state = state.copyWith(
        items: {...state.items, cartItemId: cartItem},
        error: null,
      );
    }
    
    _calculateTotals();
    _saveCartToStorage();
  }

  /// Update item quantity
  void updateQuantity(String cartItemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(cartItemId);
      return;
    }

    final currentItem = state.items[cartItemId];
    if (currentItem == null) return;

    final updatedItem = currentItem.copyWith(quantity: newQuantity);
    
    state = state.copyWith(
      items: {...state.items, cartItemId: updatedItem},
      error: null,
    );
    
    _calculateTotals();
    _saveCartToStorage();
  }

  /// Remove item from cart
  void removeItem(String cartItemId) {
    final newItems = Map<String, CartItem>.from(state.items);
    newItems.remove(cartItemId);
    
    state = state.copyWith(
      items: newItems,
      error: null,
    );
    
    _calculateTotals();
    _saveCartToStorage();
  }

  /// Clear entire cart
  void clearCart() {
    state = const CartState();
    _saveCartToStorage();
  }

  /// Get cart item by ID
  CartItem? getCartItem(String cartItemId) {
    return state.items[cartItemId];
  }

  /// Check if cart is empty
  bool get isEmpty => state.items.isEmpty;

  /// Check if cart has items
  bool get isNotEmpty => state.items.isNotEmpty;

  /// Get cart items as list
  List<CartItem> get cartItems => state.items.values.toList();

  /// Calculate totals
  void _calculateTotals() {
    int totalItems = 0;
    double totalPrice = 0.0;

    state.items.forEach((id, item) {
      totalItems += item.quantity;
      totalPrice += item.calculatedTotalPrice;
    });

    state = state.copyWith(
      totalItems: totalItems,
      totalPrice: totalPrice,
    );
  }

  /// Generate unique cart item ID based on menu item and customizations
  String _generateCartItemId(String menuItemId, Map<String, int> customizations) {
    final customizationsKey = customizations.entries
        .where((entry) => entry.value > 0)
        .map((entry) => '${entry.key}:${entry.value}')
        .join('|');
    
    return customizationsKey.isEmpty 
        ? menuItemId 
        : '${menuItemId}_$customizationsKey';
  }

  /// Add customization to existing item
  void addCustomization(String cartItemId, String supplement, int quantity) {
    final currentItem = state.items[cartItemId];
    if (currentItem == null) return;

    final newCustomizations = Map<String, int>.from(currentItem.customizations);
    newCustomizations[supplement] = (newCustomizations[supplement] ?? 0) + quantity;

    final updatedItem = currentItem.copyWith(customizations: newCustomizations);
    
    state = state.copyWith(
      items: {...state.items, cartItemId: updatedItem},
      error: null,
    );
    
    _calculateTotals();
  }

  /// Remove customization from item
  void removeCustomization(String cartItemId, String supplement) {
    final currentItem = state.items[cartItemId];
    if (currentItem == null) return;

    final newCustomizations = Map<String, int>.from(currentItem.customizations);
    newCustomizations.remove(supplement);

    final updatedItem = currentItem.copyWith(customizations: newCustomizations);
    
    state = state.copyWith(
      items: {...state.items, cartItemId: updatedItem},
      error: null,
    );
    
    _calculateTotals();
  }

  /// Set loading state
  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  /// Set error state
  void setError(String? error) {
    state = state.copyWith(error: error, isLoading: false);
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Cart Provider
/// 
/// Global cart state provider accessible throughout the app.
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

/// Cart Items Provider
/// 
/// Provides list of cart items for easy access.
final cartItemsProvider = Provider<List<CartItem>>((ref) {
  final cartState = ref.watch(cartProvider);
  return cartState.items.values.toList();
});

/// Cart Total Items Provider
/// 
/// Provides total item count for badges and displays.
final cartTotalItemsProvider = Provider<int>((ref) {
  final cartState = ref.watch(cartProvider);
  return cartState.totalItems;
});

/// Cart Total Price Provider
/// 
/// Provides total price for checkout displays.
final cartTotalPriceProvider = Provider<double>((ref) {
  final cartState = ref.watch(cartProvider);
  return cartState.totalPrice;
});

/// Cart Is Empty Provider
/// 
/// Provides boolean indicating if cart is empty.
final cartIsEmptyProvider = Provider<bool>((ref) {
  final cartState = ref.watch(cartProvider);
  return cartState.items.isEmpty;
});

/// Cart Is Not Empty Provider
/// 
/// Provides boolean indicating if cart has items.
final cartIsNotEmptyProvider = Provider<bool>((ref) {
  final cartState = ref.watch(cartProvider);
  return cartState.items.isNotEmpty;
});
