import 'package:bobo_tea/models/beverage_model.dart';
import 'package:bobo_tea/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BeverageData extends ChangeNotifier {
  final List<Beverage> beverages = [
    Beverage(
      imagePath: 'assets/blue.jpg',
      title: 'Blue Sparkling',
      ingredients: 'Tonic, agrumi blue, lemon',
      description:
          'vibrant and refreshing cocktail that combines the crispness of tonic with the zesty brightness of blue citrus and a hint of lemon. This eye-catching drink features a unique blue hue and a lively.',
      price: 8.00,
    ),
    Beverage(
      imagePath: 'assets/classico.jpg',
      title: 'Classic Bubble Tea',
      ingredients: 'Milk, black tea, tapioca ball',
      description:
          'Indulge in the timeless delight of "Classic Bubble Tea." This beloved beverage combines rich black tea with creamy milk, creating a smooth and satisfying base. The star of the show is the chewy tapioca pearls.',
      price: 10.00,
    ),
    Beverage(
      imagePath: 'assets/fragola.jpg',
      title: 'Sweet Strawberry',
      ingredients: 'Strawberry, milk',
      description:
          'Savor the irresistible charm of "Sweet Strawberry," a delightful drink that blends luscious strawberries with creamy milk. This refreshing beverage offers a burst of fruity sweetness.',
      price: 12.00,
    ),
    Beverage(
      imagePath: 'assets/lime.jpg',
      title: 'Tea with passion',
      ingredients: 'passion fruit, lime',
      description:
          'Tea with Passion" is a tantalizing fusion of vibrant passion fruit and zesty lime, offering a refreshing twist on traditional tea. The exotic tang of passion fruit harmonizes with the bright..',
      price: 10.00,
    ),
    Beverage(
      imagePath: 'assets/mango.jpg',
      title: 'Bubble tea with mango yakult',
      ingredients: 'Mango, yakult, jelly ball ',
      description:
          'This innovative beverage combines the creamy, probiotic richness of Mango Yakult with the traditional appeal of bubble tea.',
      price: 12.00,
    ),
    Beverage(
      imagePath: 'assets/pink.jpg',
      title: 'Pink Memories',
      ingredients: 'Tonic, strawberry, lemon',
      description:
          'Pink Memories" is a delightful and refreshing beverage that captures the essence of summer in every sip. This charming drink combines the crisp effervescence of tonic with the sweet and vibrant flavors of ripe strawberries and zesty lemon.',
      price: 8.00,
    ),
  ];

  List<Beverage> get favoritesList =>
      beverages.where((b) => b.isFavorite).toList();

  void toggleFavorite(Beverage beverage) {
    beverage.isFavorite = !beverage.isFavorite;
    notifyListeners();
    _saveFavorites();
  }

  BeverageData() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteBeverageTitle =
        prefs.getStringList('favoriteBeverageTitle') ?? [];
    for (var beverage in beverages) {
      beverage.isFavorite = favoriteBeverageTitle.contains(beverage.title);
    }
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteBeverageTitle =
        beverages.where((b) => b.isFavorite).map((b) => b.title).toList();
    await prefs.setStringList('favoriteBeverageTitle', favoriteBeverageTitle);
  }

  List<CartItem> cartItems = [];

  void addToCart(
      Beverage beverage, String sugarLevel, String temperatureLevel) {
    final existingIndex = cartItems.indexWhere((item) =>
        item.beverage!.title == beverage.title &&
        item.sugarLevel == sugarLevel.split('.').last &&
        item.temperatureLevel == temperatureLevel.split('.').last);

    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity++;
    } else {
      cartItems.add(CartItem(
          beverage: beverage,
          sugarLevel: sugarLevel.split('.').last,
          temperatureLevel: temperatureLevel.split('.').last));
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }

  void updateCartItemQuantity(CartItem cartItem, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(cartItem);
    }
    final index = cartItems.indexOf(cartItem);
    if (index != -1) {
      cartItems[index].quantity = newQuantity;
      totalQuantity;
      notifyListeners();
    }
  }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) => sum + item.getTotalPrice());
  }

  int get totalQuantity {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
}
