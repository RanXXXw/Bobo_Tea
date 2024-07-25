import 'package:bobo_tea/models/beverage_model.dart';
import 'package:bobo_tea/providers/beverage_provider.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final BeverageData _beverageData;

  HomeViewModel(this._beverageData);

  List<Beverage> get beverages => _beverageData.beverages;

  Future<List<Beverage>> get favorites => _beverageData.favoritesList;

  void toggleFavorite(Beverage beverage) {
    _beverageData.toggleFavorite(beverage);
    notifyListeners();
  }
}
