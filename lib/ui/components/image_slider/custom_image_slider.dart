// lib/ui/components/image_slider/custom_image_slider.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget buildImageSlider(
    BuildContext context,
    List<Map<String, String>> items,
    double height,
    BoxConstraints constraints,
    ) {
  final screenSize = MediaQuery.of(context).size;
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return CarouselSlider(
    options: CarouselOptions(
      scrollPhysics: const BouncingScrollPhysics(),
      height: height,
      autoPlay: true,
      enlargeCenterPage: true,
      aspectRatio: isPortrait ? 16 / 9 : 21 / 9,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayCurve: Curves.fastOutSlowIn,
      viewportFraction: isPortrait ? 0.85 : 0.7,
    ),
    items: items.map((item) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: constraints.maxWidth,
            margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.00,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                screenSize.width * 0.02,
              ),
              image: DecorationImage(
                image: NetworkImage(item['url'] ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  screenSize.width * 0.02,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenSize.width * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenSize.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      item['date'] ?? '',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: screenSize.width * 0.03,
                      ),
                    ),
                    if (item['description']?.isNotEmpty ?? false)
                      Text(
                        item['description']!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: screenSize.width * 0.03,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}