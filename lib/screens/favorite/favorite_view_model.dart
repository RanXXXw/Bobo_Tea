import 'package:bobo_tea/models/beverage_model.dart';
import 'package:bobo_tea/providers/beverage_provider.dart';
import 'package:flutter/material.dart';

class FavoritesViewModel extends ChangeNotifier {
  final BeverageData _beverageData;

  FavoritesViewModel(this._beverageData);
  Future<List<Beverage>> get favorites => _beverageData.favoritesList;

  void toggleFavorite(Beverage beverage) {
    _beverageData.toggleFavorite(beverage);
    notifyListeners();
  }
}
