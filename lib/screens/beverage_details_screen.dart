import 'package:bobo_tea/models/beverage_model.dart';
import 'package:bobo_tea/providers/beverage_provider.dart';
import 'package:bobo_tea/widgets/chioce_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(1, 1),
                blurRadius: 20,
              )
            ],
          ),
          child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 20, 20),
                child: IconButton.outlined(
                  icon: const Icon(Icons.arrow_back,
                      color: Color.fromARGB(255, 255, 255, 255)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              )),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 25,
            bottom: 10,
            right: 25,
            left: 25,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(beverage.title, style: const TextStyle(fontSize: 32)),
                    Text(
                      beverage.ingredients!,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 16),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 45),
                child: Text('£${beverage.price.toString()}',
                    style: const TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
                left: 22.0, top: 5.0, right: 22.0, bottom: 15.0),
            child: SingleChildScrollView(
              child: Column(children: [
                ChoiceChipGroup(
                  title: 'Sugar Level',
                  options: Sugar.values,
                  selectedValue: _sugarSelection as Sugar,
                  onSelectionChanged: (value) =>
                      setState(() => _sugarSelection = value as Sugar),
                ),
                ChoiceChipGroup(
                  title: 'Temperature',
                  options: Temperature.values,
                  selectedValue: _temperatureSelection as Temperature,
                  onSelectionChanged: (value) => setState(
                      () => _temperatureSelection = value as Temperature),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Description', style: TextStyle(fontSize: 20)),
                    Text(
                      beverage.description!,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 16),
                      softWrap: true,
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 180,
                height: 40,
                child: FilledButton(
                  onPressed: () {
                    Provider.of<BeverageData>(context, listen: false).addToCart(
                        beverage,
                        _sugarSelection!.toString(),
                        _temperatureSelection!.toString());
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Drink Added!',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        backgroundColor: Color.fromARGB(255, 194, 191, 211),
                        duration: Duration(milliseconds: 800),
                      ),
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
