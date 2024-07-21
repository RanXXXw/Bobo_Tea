import 'package:bobo_tea/providers/beverage_provider.dart';
import 'package:bobo_tea/screens/beverage_details_screen.dart';
import 'package:bobo_tea/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final beverageData = Provider.of<BeverageData>(context);
    return Scaffold(
      appBar: const ReusableAppBar(titleText: 'Favorites'),
      body: ListView.builder(
        itemCount: beverageData.favoritesList.length,
        itemBuilder: (context, index) {
          final beverage = beverageData.favoritesList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BeverageDetailPage(beverage: beverage)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 15, top: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          beverage.title,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          beverage.ingredients!,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => beverageData.toggleFavorite(beverage),
                    icon: beverage.isFavorite
                        ? Icon(Icons.favorite, color: Colors.red[300])
                        : const Icon(Icons.favorite_border),
                    tooltip: beverage.isFavorite
                        ? 'Remove from favorites'
                        : 'Add to favorites',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
