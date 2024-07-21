import 'package:bobo_tea/models/cart_model.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalPrice;
  final DateTime timeStamp;

  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.timeStamp,
  });
}
