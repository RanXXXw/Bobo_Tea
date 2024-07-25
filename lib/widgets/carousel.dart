import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bobo_tea/resources/resources.dart';

class PosterCarousel extends StatelessWidget {
  final List<String> imagePaths;

  const PosterCarousel({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    final imageSliders = imagePaths
        .map((item) => Container(
              margin: const EdgeInsets.all(AppDimens.paddingMarginXXS),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(AppDimens.radiusSM)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: AppDimens.widthXXXL),
                  ],
                ),
              ),
            ))
        .toList();

    return CarouselSlider(
      items: imageSliders,
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: AppDimens.radiusXS,
        enlargeCenterPage: true,
      ),
    );
  }
}