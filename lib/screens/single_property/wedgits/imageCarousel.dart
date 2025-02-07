import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:homedeals/models/property_model.dart';

class ImageCarousel extends StatefulWidget {
  final Property property;

  const ImageCarousel({required this.property});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int currentSlide = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        CarouselSlider(
          items: widget.property.photos!.map((photoUrl) {
            return Builder(
              builder: (BuildContext context) {
                return CachedNetworkImage(
                  imageUrl: photoUrl,
                  fit: BoxFit.cover,
                  width: screenWidth * 0.7,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(child: Text('Error loading image')),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 500,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentSlide = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(height: 10),
        _buildImageThumbnails(screenWidth),
      ],
    );
  }

  Widget _buildImageThumbnails(double screenWidth) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.property.photos!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _carouselController.jumpTo(index as double);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: currentSlide == index ? Colors.red : Colors.transparent,
                  width: 2,
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.property.photos![index],
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(child: Text('Error loading image')),
              ),
            ),
          );
        },
      ),
    );
  }
}
