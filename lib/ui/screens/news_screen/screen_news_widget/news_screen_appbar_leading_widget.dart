import 'dart:ui';
import 'package:cosmospedia/utils/app_colors.dart';
import 'package:cosmospedia/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget newsAppBarLeadingWidget({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.all(SizeConfig.devicePixelRatio(7)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(
        SizeConfig.devicePixelRatio(10),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundDark.withOpacity(0.2),
            borderRadius: BorderRadius.circular(
              SizeConfig.devicePixelRatio(10),
            ),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.backgroundLight,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    ),
  );
}

