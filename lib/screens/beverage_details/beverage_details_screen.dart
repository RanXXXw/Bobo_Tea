import 'package:bobo_tea/models/beverage_model.dart';
import 'package:bobo_tea/resources/resources.dart';
import 'package:bobo_tea/screens/beverage_details/beverage_details_view_model.dart';
import 'package:bobo_tea/widgets/chioce_chip.dart';
import 'package:flutter/material.dart';

class BeverageDetailPage extends StatefulWidget {
  final Beverage beverage;

  const BeverageDetailPage({super.key, required this.beverage});

  @override
  State<BeverageDetailPage> createState() => _BeverageDetailPageState();
}

class _BeverageDetailPageState extends State<BeverageDetailPage> {
  Sugar? _sugarSelection = Sugar.Normal;
  Temperature? _temperatureSelection = Temperature.Room;

  @override
  Widget build(BuildContext context) {
    final beverage = widget.beverage;
    final viewModel = BeverageDetailViewModel(beverage);
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(beverage.imagePath!),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(AppDimens.radiusL),
              bottomLeft: Radius.circular(AppDimens.radiusL),
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.boxShadow,
                offset: Offset(1, 1),
                blurRadius: AppDimens.radiusML,
              )
            ],
          ),
          child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.paddingMarginM),
                child: IconButton.outlined(
                  icon: const Icon(Icons.arrow_back, color: AppColors.arrow),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: AppColors.arrowCircle,
                      width: AppDimens.widthXXS,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              )),
        ),
        Container(
          padding: const EdgeInsets.all(AppDimens.paddingMarginSM),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(beverage.title,
                        style: const TextStyle(fontSize: AppDimens.textXL)),
                    Text(
                      beverage.ingredients!,
                      style: AppTextStyles.small,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(bottom: AppDimens.paddingMarginXXL),
                child: Text('£${beverage.price.toString()}',
                    style: const TextStyle(fontSize: AppDimens.textL)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
                left: AppDimens.paddingMarginM,
                right: AppDimens.paddingMarginM,
                bottom: AppDimens.paddingMarginSM),
            child: SingleChildScrollView(
              child: Column(children: [
                ChoiceChipGroup(
                  title: AppStrings.chioceChipSugar,
                  options: Sugar.values,
                  selectedValue: _sugarSelection as Sugar,
                  onSelectionChanged: (value) =>
                      setState(() => _sugarSelection = value as Sugar),
                ),
                ChoiceChipGroup(
                  title: AppStrings.chioceChipTemperature,
                  options: Temperature.values,
                  selectedValue: _temperatureSelection as Temperature,
                  onSelectionChanged: (value) => setState(
                      () => _temperatureSelection = value as Temperature),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(AppStrings.descriptionTitle,
                        style: TextStyle(fontSize: AppDimens.textM)),
                    Text(
                      beverage.description!,
                      style: AppTextStyles.small,
                      softWrap: true,
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              bottom: AppDimens.paddingMarginSM,
              right: AppDimens.paddingMarginSM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: AppDimens.widthL,
                height: AppDimens.heightS,
                child: FilledButton(
                  onPressed: () {
                    viewModel.addToCart(context, _sugarSelection!.toString(),
                        _temperatureSelection!.toString());
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          AppStrings.snackBar,
                          style: TextStyle(color: AppColors.snackBar),
                        ),
                        backgroundColor: AppColors.tertiary,
                        duration: Duration(milliseconds: 800),
                      ),
                    );
                  },
                  child: const Text(AppStrings.addButton),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
