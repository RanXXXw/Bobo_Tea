import 'package:bobo_tea/models/beverage_model.dart';
import 'package:bobo_tea/resources/resources.dart';
import 'package:bobo_tea/screens/beverage_details/beverage_details_screen.dart';
import 'package:bobo_tea/screens/home/home_view_model.dart';
import 'package:bobo_tea/widgets/carousel.dart';
import 'package:bobo_tea/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<String> images = [
  'assets/poster_1.jpg',
  'assets/poster_2.jpg',
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
        appBar: const ReusableAppBar(titleText: AppStrings.homeNav),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(AppDimens.paddingMarginXS),
                  child: Text(AppStrings.homeCarousel,
                      style: AppTextStyles.large)),
              PosterCarousel(imagePaths: images),
              Padding(
                  padding: const EdgeInsets.all(AppDimens.paddingMarginXS),
                  child: Text(AppStrings.homeBeverage,
                      style: AppTextStyles.large)),
              for (final beverage in viewModel.beverages)
                Card.outlined(
                  color: AppColors.card,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppDimens.radiusM)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(AppDimens.radiusM),
                            bottomLeft: Radius.circular(AppDimens.radiusM)),
                        child: Image.asset(
                          beverage.imagePath!,
                          height: AppDimens.heightML,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                '${beverage.title}  \$${beverage.price}',
                                style:
                                    const TextStyle(fontSize: AppDimens.textM),
                              ),
                              subtitle: Text(
                                beverage.ingredients!,
                                style: AppTextStyles.small,
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      viewModel.toggleFavorite(beverage);
                                    },
                                    icon: FutureBuilder<List<Beverage>>(
                                      future: viewModel.favorites,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return snapshot.data!
                                                  .contains(beverage)
                                              ? const Icon(Icons.favorite,
                                                  color: AppColors.favoriteIcon)
                                              : const Icon(
                                                  Icons.favorite_border);
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    )),
                                SizedBox(
                                  width: AppDimens.widthML,
                                  height: AppDimens.heightS,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BeverageDetailPage(
                                                    beverage: beverage)),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColors.selectButton,
                                    ),
                                    child: Text(
                                      AppStrings.selectButton,
                                      style: AppTextStyles.medium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ));
  }
}
