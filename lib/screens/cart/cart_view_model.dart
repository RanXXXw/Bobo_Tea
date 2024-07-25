import 'package:bobo_tea/models/order_model.dart';
import 'package:bobo_tea/services/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:bobo_tea/providers/beverage_provider.dart';
import 'package:bobo_tea/models/cart_model.dart';

class CartViewModel extends ChangeNotifier {
  final BeverageData _beverageData;
  final DatabaseHelper _databaseHelper;

  CartViewModel(this._beverageData, this._databaseHelper);

  List<CartItem> get cartItems => _beverageData.cartItems;

  double get totalPrice => _beverageData.totalPrice;

  int get totalQuantity => _beverageData.totalQuantity;

  void updateCartItemQuantity(CartItem cartItem, int newQuantity) {
    _beverageData.updateCartItemQuantity(cartItem, newQuantity);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _beverageData.removeFromCart(item);
    notifyListeners();
  }

  void clearCart() {
    _beverageData.clearCart();
    notifyListeners();
  }

  Future<void> placeOrder() async {
    final order = Order(
      id: UniqueKey().toString(),
      items: cartItems.toList(),
      totalPrice: totalPrice,
      timeStamp: DateTime.now(),
    );
    await _databaseHelper.insertOrder(order);
    clearCart();
    notifyListeners();
  }
}
