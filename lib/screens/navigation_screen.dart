
import 'package:bobo_tea/providers/beverage_provider.dart';
import 'package:bobo_tea/screens/cart_screen.dart';
import 'package:bobo_tea/screens/favorite_screen.dart';
import 'package:bobo_tea/screens/home_screen.dart';
import 'package:bobo_tea/screens/info_screen.dart';
import 'package:bobo_tea/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final beverageData = Provider.of<BeverageData>(context);

    return Scaffold(
        body: _pages[currentPageIndex],
        bottomNavigationBar: NavigationBar(
            backgroundColor: const Color.fromARGB(255, 226, 224, 239),
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            indicatorColor: const Color.fromARGB(255, 169, 165, 200),
            selectedIndex: currentPageIndex,
            destinations: <Widget>[
              const NavigationDestination(
                icon: Icon(Icons.help_outline),
                label: 'Info',
                tooltip: '',
              ),
              const NavigationDestination(
                selectedIcon: Icon(Icons.favorite),
                icon: Icon(Icons.favorite_border),
                label: 'Favorites',
                tooltip: '',
              ),
              const NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Menù',
                tooltip: '',
              ),
              NavigationDestination(
                selectedIcon: const Icon(Icons.shopping_cart),
                icon: Badge(
                  label: Text('${beverageData.totalQuantity}'),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                label: 'Cart',
                tooltip: '',
              ),
              const NavigationDestination(
                icon: Icon(Icons.history),
                label: 'Order',
                tooltip: '',
              ),
            ]));
  }
}


