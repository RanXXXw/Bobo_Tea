import 'package:bobo_tea/screens/order/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:bobo_tea/models/order_model.dart';
import 'package:bobo_tea/resources/resources.dart';
import 'package:bobo_tea/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';


class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final OrdersViewModel _viewModel = OrdersViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(titleText: AppStrings.orderNav),
      body: ValueListenableBuilder<List<Order>>(
        valueListenable: _viewModel.ordersNotifier,
        builder: (context, orders, child) {
          return orders.isEmpty
              ? const Center(
                  child: Text(
                    AppStrings.emptyOrder,
                    style: TextStyle(fontSize: AppDimens.textL),
                  ),
                )
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders.reversed.toList()[index];
                    return Dismissible(
                      key: Key(order.id),
                      background: Container(
                        color: AppColors.deleteDismissible,
                        child: const Icon(Icons.delete,
                            color: AppColors.deleteIconDismissible),
                      ),
                      onDismissed: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          await _viewModel.deleteOrder(order.id);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: AppDimens.paddingMarginXS,
                            left: AppDimens.paddingMarginSM,
                            right: AppDimens.paddingMarginSM),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order ID : ${order.id}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimens.textL),
                            ),
                            const SizedBox(height: AppDimens.heightXXS),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: order.items.length,
                              itemBuilder: (context, beverageIndex) {
                                final item = order.items[beverageIndex];
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            ' ${item.quantity} x ${item.beverage!.title}',
                                            style: const TextStyle(
                                                fontSize: AppDimens.textM),
                                          ),
                                          Text(
                                            ' \$${item.beverage!.price}',
                                            style: const TextStyle(
                                                fontSize: AppDimens.textM),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppDimens.paddingMarginXL),
                                        child: Text(
                                          '(${item.sugarLevel} sugar - ${item.temperatureLevel})',
                                          style: AppTextStyles.small,
                                        ),
                                      )
                                    ]);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: AppDimens.paddingMarginSM,
                                  bottom: AppDimens.paddingMarginXXS),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${DateFormat('yyyy-MM-dd').format(order.timeStamp)} ${DateFormat('HH:mm').format(order.timeStamp)}  ',
                                    style: const TextStyle(
                                        fontSize: AppDimens.textS),
                                  ),
                                  Text(
                                    'Total Price: \$${order.totalPrice.toStringAsFixed(2)}',
                                    style: AppTextStyles.mediumBoldBlack,
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
                );
        },
      ),
    );
  }
}
