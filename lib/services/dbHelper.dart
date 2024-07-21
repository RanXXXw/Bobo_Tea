import 'dart:convert';
import 'package:bobo_tea/models/beverage_model.dart';
import 'package:bobo_tea/models/cart_model.dart';
import 'package:bobo_tea/models/order_model.dart';
import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseHelper {
  static const _databaseName = 'orders.db';
  static const _databaseVersion = 1;

  Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$_databaseName';
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE Orders (
            id TEXT PRIMARY KEY,
            items TEXT NOT NULL,
            total_price REAL NOT NULL,
            timestamp DATETIME NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertOrder(Order order) async {
    final db = await database;
    final itemsJson = jsonEncode(order.items
        .map((i) => {
              'title': i.beverage!.title,
              'price': i.beverage!.price,
              'quantity': i.quantity,
              'sugar': i.sugarLevel,
              'temperature': i.temperatureLevel
            })
        .toList());
    try {
      await db.insert('Orders', <String, dynamic>{
        'id': UniqueKey().toString(),
        'items': itemsJson,
        'total_price': order.totalPrice,
        'timestamp': DateTime.now().toString(),
      });
    } catch (e) {
      throw Exception(
          'Error inserting order: $e'); 
    }
  }

  Future<List<Order>> getOrders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Orders');

    final orders = List<Order>.generate(maps.length, (i) {
      final itemsJson = maps[i]['items'];
      List<CartItem> items = [];
      print(itemsJson);

      if (itemsJson is String) {
        items = (jsonDecode(itemsJson) as List<dynamic>)
            .map((i) => CartItem(
                  beverage: Beverage(
                    title: i['title'] as String,
                    price: i['price'] as double,
                  ),
                  quantity: i['quantity'] as int,
                  sugarLevel: i['sugar'] as String,
                  temperatureLevel: i['temperature'] as String?,
                ))
            .toList();
      }

      return Order(
        id: maps[i]['id'],
        items: items,
        totalPrice: maps[i]['total_price'] as double,
        timeStamp: DateTime.parse(maps[i]['timestamp']),
      );
    });

    return orders;
  }

  Future<int> deleteOrder(String id) async {
    final db = await database;
    return await db.delete(
      'Orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
