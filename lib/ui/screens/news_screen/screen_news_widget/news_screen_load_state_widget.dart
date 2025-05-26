import 'dart:ui';

import 'package:cosmospedia/ui/screens/news_screen/news_image_preview/news_image_preview.dart';
import 'package:cosmospedia/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/apod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/size_config.dart';

Widget buildLoadedState(BuildContext context, ApodModel news) {
  SizeConfig.init(context);

  final l10n = AppLocalizations.of(context);
  return Stack(
    children: [
      // Full-screen image
      Image.network(
        news.url,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),

      // Gradient overlay
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.newsScreenGradient,
            stops: const [0.0, 0.3, 0.6, 1.0],
          ),
        ),
      ),

      // Scrollable content
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Space for AppBar
            SizedBox(height: SizeConfig.height(9.5)),

            // Title section with blur effect
            Padding(
              padding: EdgeInsets.all(SizeConfig.width(5)),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(SizeConfig.devicePixelRatio(20)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.width(6)),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.backgroundLight.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title,
                          style: TextStyle(
                            color: AppColors.textPrimaryDark,
                            fontSize: SizeConfig.devicePixelRatio(32),
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: SizeConfig.height(2)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width(4),
                            vertical: SizeConfig.height(1),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                                SizeConfig.devicePixelRatio(30)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: AppColors.newsCalendarIconColor,
                                size: SizeConfig.devicePixelRatio(16),
                              ),
                              SizedBox(width: SizeConfig.width(2)),
                              Text(
                                DateTime.parse(news.date)
                                    .toString()
                                    .substring(0, 10),
                                style: TextStyle(
                                  color: AppColors.textPrimaryDark,
                                  fontSize: SizeConfig.devicePixelRatio(14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Main content with blur effect
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(4)),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(SizeConfig.devicePixelRatio(20)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.width(6)),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDark.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(
                          SizeConfig.devicePixelRatio(20)),
                      border: Border.all(
                        color: AppColors.backgroundLight.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.explanation,
                          style: TextStyle(
                            color: AppColors.textPrimaryDark,
                            fontSize: SizeConfig.devicePixelRatio(18),
                            height: 1.8,
                            letterSpacing: 0.3,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        if (news.copyright != null &&
                            news.copyright!.isNotEmpty) ...[
                          SizedBox(height: SizeConfig.height(4)),
                          Text(
                            '© ${news.copyright}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: SizeConfig.devicePixelRatio(14),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                        SizedBox(height: SizeConfig.height(4)),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: AppColors.imagePreviewButtonGradient),
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.devicePixelRatio(30)),
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.width(6.2),
                                  vertical: SizeConfig.height(1.5),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.devicePixelRatio(30)),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    l10n!.imagePreview,
                                    style: TextStyle(
                                      color: AppColors.textPrimaryDark,
                                      fontSize: SizeConfig.devicePixelRatio(16),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(width: SizeConfig.width(2)),
                                  Icon(
                                    Icons.rocket_launch,
                                    color: AppColors.newsRocketIconColor,
                                    size: SizeConfig.devicePixelRatio(20),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ImagePreview(apod: news),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: (SizeConfig.height(4))),
          ],
        ),
      ),
    ],
  );
}
