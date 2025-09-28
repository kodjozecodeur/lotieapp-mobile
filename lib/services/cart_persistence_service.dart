import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/cart_provider.dart';

/// Cart Persistence Service
/// 
/// Handles saving and loading cart state to/from local storage.
class CartPersistenceService {
  static const String _cartKey = 'cart_items';
  
  /// Save cart state to local storage
  static Future<void> saveCartState(CartState cartState) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = cartState.toJson();
      final cartString = jsonEncode(cartJson);
      await prefs.setString(_cartKey, cartString);
    } catch (e) {
      print('[CartPersistenceService] Error saving cart: $e');
    }
  }
  
  /// Load cart state from local storage
  static Future<CartState?> loadCartState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartString = prefs.getString(_cartKey);
      
      if (cartString == null) return null;
      
      final cartJson = jsonDecode(cartString) as Map<String, dynamic>;
      return CartState.fromJson(cartJson);
    } catch (e) {
      print('[CartPersistenceService] Error loading cart: $e');
      return null;
    }
  }
  
  /// Clear cart from local storage
  static Future<void> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cartKey);
    } catch (e) {
      print('[CartPersistenceService] Error clearing cart: $e');
    }
  }
  
  /// Check if cart exists in storage
  static Future<bool> hasCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_cartKey);
    } catch (e) {
      print('[CartPersistenceService] Error checking cart: $e');
      return false;
    }
  }
}
