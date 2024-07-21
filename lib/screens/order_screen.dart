import 'package:bobo_tea/models/order_model.dart';
import 'package:bobo_tea/services/dbHelper.dart';
import 'package:bobo_tea/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  List<Order> orders = [];

  refresh() {
    _databaseHelper.getOrders().then((value) {
      setState(() {
        orders = value;
      });
    });
  }

  Future<List<Order>> getOrders() async {
    return await _databaseHelper.getOrders();
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(titleText: 'Orders'),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                'No orders found',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders.reversed.toList()[index];
                return Dismissible(
                  key: Key(order.id),
                  background: Container(
                    color: const Color.fromARGB(255, 247, 177, 169),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      int result = await _databaseHelper.deleteOrder(order.id);
                      if (result == 1) {
                        setState(() {
                          orders.remove(order);
                        });
                      } else {
                        print('Error deleting order');
                      }
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID : ${order.id}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: order.items.length,
                          itemBuilder: (context, beverageIndex) {
                            final item = order.items[beverageIndex];
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ' ${item.quantity} x ${item.beverage!.title}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        ' \$${item.beverage!.price}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35),
                                    child: Text(
                                      '(${item.sugarLevel} sugar - ${item.temperatureLevel})',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 16),
                                    ),
                                  )
                                ]);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${DateFormat('yyyy-MM-dd').format(order.timeStamp)} ${DateFormat('HH:mm').format(order.timeStamp)}   ',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Total Price: \$${order.totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
