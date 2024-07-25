import 'package:bobo_tea/models/beverage_model.dart';
import 'package:bobo_tea/resources/resources.dart';
import 'package:bobo_tea/screens/beverage_details/beverage_details_screen.dart';
import 'package:bobo_tea/screens/favorite/favorite_view_model.dart';
import 'package:bobo_tea/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FavoritesViewModel>(context);
    return Scaffold(
        appBar: const ReusableAppBar(titleText: AppStrings.favoritesNav),
        body: FutureBuilder<List<Beverage>>(
            future: viewModel.favorites,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final favorites = snapshot.data!;
                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final beverage = favorites[index];
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
                        padding: const EdgeInsets.only(
                            left: AppDimens.paddingMarginM,
                            right: AppDimens.paddingMarginSM,
                            top: AppDimens.paddingMarginSM),
                        child: Row(
                          children: [
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
                                    beverage.ingredients!,
                                    softWrap: true,
                                    style: AppTextStyles.small,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  viewModel.toggleFavorite(beverage),
                              icon: beverage.isFavorite
                                  ? const Icon(Icons.favorite,
                                      color: AppColors.favoriteIcon)
                                  : const Icon(Icons.favorite_border),
                              tooltip: beverage.isFavorite
                                  ? AppStrings.tooltipFavoriteRemove
                                  : AppStrings.tooltipFavoriteAdd,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
