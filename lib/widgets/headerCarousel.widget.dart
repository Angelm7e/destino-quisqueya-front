import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HeaderCarousel extends StatelessWidget {
  final List<String> images;
  final bool isAsset;
  final int autoPlayInterval;

  const HeaderCarousel({
    super.key,
    required this.images,
    this.isAsset = true,
    this.autoPlayInterval = 10,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIdx) {
        final src = images[index];
        return SizedBox.expand(
          child: isAsset
              ? Image.asset(src, fit: BoxFit.cover, width: double.infinity)
              : Image.network(src, fit: BoxFit.cover, width: double.infinity),
        );
      },
      options: CarouselOptions(
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        height: double.infinity,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: autoPlayInterval),
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        enableInfiniteScroll: true,
      ),
    );
  }
}
