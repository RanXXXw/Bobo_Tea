import 'package:bobo_tea/models/beverage_model.dart';
import 'package:bobo_tea/providers/beverage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeverageDetailViewModel {
  final Beverage beverage;
  BeverageData? _beverageData;

  BeverageDetailViewModel(this.beverage);

  void addToCart(BuildContext context, String sugar, String temperature) {
    _beverageData = Provider.of<BeverageData>(context, listen: false);
    _beverageData?.addToCart(beverage, sugar, temperature);
  }
}
