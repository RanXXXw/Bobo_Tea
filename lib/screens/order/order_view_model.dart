import 'dart:async';
import 'package:bobo_tea/models/order_model.dart';
import 'package:bobo_tea/services/dbHelper.dart';
import 'package:flutter/material.dart';

class OrdersViewModel extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  final ValueNotifier<List<Order>> ordersNotifier = ValueNotifier([]);

  List<Order> get orders => ordersNotifier.value;

  Future<void> fetchOrders() async {
    final orders = await _databaseHelper.getOrders();
    ordersNotifier.value = orders;
    notifyListeners();
  }

  Future<void> deleteOrder(String id) async {
    await _databaseHelper.deleteOrder(id);
    ordersNotifier.value = orders.where((order) => order.id != id).toList();
    notifyListeners();
  }
}
