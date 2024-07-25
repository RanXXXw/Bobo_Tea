import 'package:bobo_tea/providers/beverage_provider.dart';
import 'package:bobo_tea/screens/cart/cart_view_model.dart';
import 'package:bobo_tea/screens/favorite/favorite_view_model.dart';
import 'package:bobo_tea/screens/home/home_view_model.dart';
import 'package:bobo_tea/screens/navigation/navigation_screen.dart';
import 'package:bobo_tea/services/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = DatabaseHelper.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BeverageData()),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(
            Provider.of<BeverageData>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritesViewModel(
            Provider.of<BeverageData>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CartViewModel(
            Provider.of<BeverageData>(context, listen: false),
            databaseHelper,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bobo Tea',
      home: NavigationPage(),
    );
  }
}
