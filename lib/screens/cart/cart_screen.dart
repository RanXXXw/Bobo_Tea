import 'package:bobo_tea/resources/resources.dart';
import 'package:bobo_tea/screens/cart/cart_view_model.dart';
import 'package:bobo_tea/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CartViewModel>(context);

    return Scaffold(
        appBar: const ReusableAppBar(titleText: AppStrings.cartNav),
        body: viewModel.cartItems.isEmpty
            ? const Center(
                child: Text(
                  AppStrings.emptyCart,
                  style: TextStyle(fontSize: AppDimens.textL),
                ),
              )
            : Column(children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = viewModel.cartItems[index];
                      final beverage = cartItem.beverage;
                      return Row(
                        children: [
                          Image.asset(
                            beverage!.imagePath!,
                            width: AppDimens.widthML,
                            height: AppDimens.heightM,
                          ),
                          const SizedBox(width: AppDimens.widthXS),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  beverage.title,
                                  style: const TextStyle(
                                      fontSize: AppDimens.textM),
                                ),
                                Text(
                                  '${cartItem.sugarLevel!.split('.').last} Sugar',
                                  style: AppTextStyles.small,
                                ),
                                Text(
                                  'Temperature : ${cartItem.temperatureLevel!.split('.').last}',
                                  style: AppTextStyles.small,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                viewModel.updateCartItemQuantity(
                                    cartItem, cartItem.quantity - 1);
                              },
                              icon: const Icon(Icons.remove)),
                          Text('x${cartItem.quantity}',
                              style: AppTextStyles.small),
                          IconButton(
                              onPressed: () {
                                viewModel.updateCartItemQuantity(
                                    cartItem, cartItem.quantity + 1);
                              },
                              icon: const Icon(Icons.add)),
                          IconButton(
                              onPressed: () {
                                viewModel.removeFromCart(cartItem);
                              },
                              icon: const Icon(Icons.delete)),
                          const SizedBox(width: AppDimens.widthM),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(height: AppDimens.heightXXS),
                Container(
                  padding: const EdgeInsets.all(AppDimens.paddingMarginSM),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStrings.totalPrice,
                              style: AppTextStyles.largeBold),
                          Text('\$ ${viewModel.totalPrice}',
                              style: AppTextStyles.largeBold),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: AppDimens.paddingMarginXS,
                            bottom: AppDimens.paddingMarginM),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              AppStrings.quantity,
                              style: TextStyle(fontSize: AppDimens.textM),
                            ),
                            Text('${viewModel.totalQuantity}',
                                style:
                                    const TextStyle(fontSize: AppDimens.textM)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: AppDimens.widthXL,
                        height: AppDimens.heightS,
                        child: FilledButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(AppStrings.alertTitle),
                              content: Text(
                                  'Your order for \$${viewModel.totalPrice.toStringAsFixed(2)} has been placed.'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await viewModel.placeOrder();
                                    Navigator.pop(context);
                                  },
                                  child: const Text(AppStrings.confirmAlert),
                                ),
                              ],
                            ),
                          ),
                          child: Text(
                            AppStrings.sendOrderButton,
                            style: AppTextStyles.smallBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]));
  }
}
