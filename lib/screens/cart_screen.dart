import 'package:bobo_tea/models/order_model.dart';
import 'package:bobo_tea/providers/beverage_provider.dart';
import 'package:bobo_tea/services/dbHelper.dart';
import 'package:bobo_tea/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final beverageData = Provider.of<BeverageData>(context);

    return Scaffold(
        appBar: const ReusableAppBar(titleText: 'Cart'),
        body: beverageData.cartItems.isEmpty
            ? const Center(
                child: Text(
                  'The cart is empty',
                  style: TextStyle(fontSize: 24),
                ),
              )
            : Column(children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: beverageData.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = beverageData.cartItems[index];
                      final beverage = cartItem.beverage;
                      return Row(
                        children: [
                          Image.asset(
                            beverage!.imagePath!,
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  beverage.title,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  '${cartItem.sugarLevel!.split('.').last} Sugar',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16),
                                ),
                                Text(
                                  'Temperature : ${cartItem.temperatureLevel!.split('.').last}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Provider.of<BeverageData>(context,
                                        listen: false)
                                    .updateCartItemQuantity(
                                        cartItem, cartItem.quantity - 1);
                              },
                              icon: const Icon(Icons.remove)),
                          Text('x${cartItem.quantity}',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.6),
                                  fontSize: 16)),
                          IconButton(
                              onPressed: () {
                                Provider.of<BeverageData>(context,
                                        listen: false)
                                    .updateCartItemQuantity(
                                        cartItem, cartItem.quantity + 1);
                              },
                              icon: const Icon(Icons.add)),
                          IconButton(
                              onPressed: () {
                                beverageData.removeFromCart(cartItem);
                              },
                              icon: const Icon(Icons.delete)),
                          const SizedBox(width: 20.0),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(height: 10),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Totale Price:',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Text('\$ ${beverageData.totalPrice}',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Quantity:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text('${beverageData.totalQuantity}',
                                style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 380,
                        height: 50,
                        child: FilledButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Order Sent'),
                              content: Text(
                                  'Your order for \$${beverageData.totalPrice.toStringAsFixed(2)} has been placed.'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    final beverageData =
                                        Provider.of<BeverageData>(context,
                                            listen: false);
                                    final order = Order(
                                      id: UniqueKey().toString(),
                                      items: beverageData.cartItems.toList(),
                                      totalPrice: beverageData.totalPrice,
                                      timeStamp: DateTime.now(),
                                    );
                                    await DatabaseHelper.instance
                                        .insertOrder(order);
                                    beverageData.clearCart();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                          child: const Text(
                            'Send Order',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]));
  }
}
