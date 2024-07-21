enum Sugar { No, Less, Normal, Extra }

enum Temperature { Hot, Room, Cold, Iced }

class Beverage {
  final String title;
  final double? price;
  final String? imagePath;
  final String? description;
  final String? ingredients;
  bool isFavorite;

  Beverage({
    required this.title,
    required this.price,
    this.imagePath,
    this.description,
    this.ingredients,
    this.isFavorite = false,
  });
}
