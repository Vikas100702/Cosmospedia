import 'package:flutter/material.dart';

import '../../../../data/models/apod.dart';
import '../../../../l10n/app_localizations.dart';


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