import 'package:bobo_tea/models/beverage_model.dart';

class CartItem {
  final Beverage? beverage;
  final String? sugarLevel;
  final String? temperatureLevel;
  int quantity;

  CartItem(
      {this.beverage,
      this.quantity = 1,
      required this.sugarLevel,
      required this.temperatureLevel});

  double getTotalPrice() {
    return beverage!.price! * quantity;
  }
}
