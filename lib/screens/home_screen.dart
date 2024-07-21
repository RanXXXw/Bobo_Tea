import 'package:bobo_tea/providers/beverage_provider.dart';
import 'package:bobo_tea/screens/beverage_details_screen.dart';
import 'package:bobo_tea/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

List<String> images = [
  'assets/poster_1.jpg',
  'assets/poster_2.jpg',
];

final List<Widget> imageSliders = images
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ))
    .toList();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final beverageData = Provider.of<BeverageData>(context);
    return Scaffold(
        appBar: const ReusableAppBar(titleText: 'Order your Tea'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Limited Edition of Summer',
                      style: GoogleFonts.robotoSlab(
                          color: Colors.black, fontSize: 26))),
              CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Pick your Beverage',
                      style: GoogleFonts.robotoSlab(
                          color: Colors.black, fontSize: 24))),
              for (final beverage in beverageData.beverages)
                Card.outlined(
                  color: const Color.fromARGB(5, 50, 50, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0)),
                        child: Image.asset(
                          beverage.imagePath!,
                          height: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                '${beverage.title}  \$${beverage.price}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                beverage.ingredients!,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 16),
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      beverageData.toggleFavorite(beverage),
                                  icon: beverage.isFavorite
                                      ? Icon(Icons.favorite,
                                          color: Colors.red[300])
                                      : const Icon(Icons.favorite_border),
                                  tooltip: beverage.isFavorite
                                      ? 'Remove from favorites'
                                      : 'Add to favorites',
                                ),
                                SizedBox(
                                  width: 90.0,
                                  height: 40.0,
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
                                      backgroundColor: const Color.fromARGB(
                                          255, 224, 186, 205),
                                    ),
                                    child: const Text(
                                      'Select',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
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
