import 'package:bobo_tea/resources/resources.dart';
import 'package:bobo_tea/screens/cart/cart_screen.dart';
import 'package:bobo_tea/screens/favorite/favorite_screen.dart';
import 'package:bobo_tea/screens/home/home_screen.dart';
import 'package:bobo_tea/screens/info/info_screen.dart';
import 'package:bobo_tea/screens/order/order_screen.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentPageIndex = 2;
  final List<Widget> _pages = [
    const InfoPage(),
    const FavoritesPage(),
    const HomePage(),
    const CartPage(),
    const OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[currentPageIndex],
        bottomNavigationBar: NavigationBar(
            backgroundColor: AppColors.primary,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            indicatorColor: AppColors.tertiary,
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.help_outline),
                label: AppStrings.infoNavLabel,
                tooltip: AppStrings.infoNavTooltip,
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.favorite),
                icon: Icon(Icons.favorite_border),
                label: AppStrings.favoritesNavLabel,
                tooltip: AppStrings.favoritesNavTooltip,
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: AppStrings.homeNavLabel,
                tooltip: AppStrings.homeNavTooltip,
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.shopping_cart),
                icon: Icon(Icons.shopping_cart_outlined),
                label: AppStrings.cartNavLabel,
                tooltip: AppStrings.cartNavTooltip,
              ),
              NavigationDestination(
                icon: Icon(Icons.history),
                label: AppStrings.orderNavLabel,
                tooltip: AppStrings.orderNavTooltip,
              ),
            ]));
  }
}
