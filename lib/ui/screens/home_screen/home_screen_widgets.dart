import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../data/models/apod.dart';
import '../../../l10n/app_localizations.dart';

Widget buildImageSlider(
  BuildContext context,
  List<ApodModel> images,
  double height,
  BoxConstraints constraints,
) {
  final screenSize = MediaQuery.of(context).size;
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return CarouselSlider(
    options: CarouselOptions(
      height: height,
      autoPlay: true,
      enlargeCenterPage: true,
      aspectRatio: isPortrait ? 16 / 9 : 21 / 9,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayCurve: Curves.fastOutSlowIn,
      viewportFraction: isPortrait ? 0.85 : 0.7,
    ),
    items: images.map((image) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: constraints.maxWidth,
            margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.02,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                screenSize.width * 0.02,
              ),
              image: DecorationImage(
                image: NetworkImage(image.url),
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
                padding: EdgeInsets.all(screenSize.width * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      image.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenSize.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      image.date,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: screenSize.width * 0.03,
                      ),
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

Widget buildNewsList(
    BuildContext context,
    List<ApodModel> news,
    BoxConstraints constraints,
    ) {
  final l10n = AppLocalizations.of(context);
  final screenSize = MediaQuery.of(context).size;
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  // Calculate dynamic padding and spacing
  final horizontalPadding = screenSize.width * 0.04;
  final verticalPadding = screenSize.height * 0.02;
  final cardSpacing = screenSize.height * 0.02;

  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n!.homeLatestNews,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: screenSize.height * 0.02),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isPortrait ? 1 : 2,
            childAspectRatio: isPortrait ? 1.2 : 1.5,
            crossAxisSpacing: horizontalPadding,
            mainAxisSpacing: verticalPadding,
          ),
          itemCount: news.length,
          itemBuilder: (context, index) {
            final item = news[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  screenSize.width * 0.02,
                ),
              ),
              child: InkWell(
                onTap: () {
                  // Navigate to news detail
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(screenSize.width * 0.02),
                      ),
                      child: Image.network(
                        item.url,
                        height: isPortrait
                            ? screenSize.height * 0.2
                            : screenSize.height * 0.25,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(screenSize.width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: screenSize.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: screenSize.height * 0.01),
                            Expanded(
                              child: Text(
                                item.explanation,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: screenSize.width * 0.035,
                                ),
                                maxLines: isPortrait ? 3 : 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: screenSize.height * 0.01),
                            Text(
                              item.date,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: screenSize.width * 0.03,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
