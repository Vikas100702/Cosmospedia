import 'dart:math';

import 'package:cosmospedia/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/size_config.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    return AppBar(
      excludeHeaderSemantics: true,
      backgroundColor: AppColors.transparentColor,
      foregroundColor: AppColors.transparentColor,
      forceMaterialTransparency: true,
      automaticallyImplyLeading: false,
      title: Text(
        l10n!.appName,
        style: TextStyle(
          color: AppColors.backgroundLight,
          fontWeight: FontWeight.bold,
            fontSize: screenSize.width * 0.05
        ),
      ),
      actions: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications),
              color: AppColors.primaryLight,
              onPressed: () {
                // Handle notification icon tap
              },
            ),
            /*Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                color: AppColors.primaryLight,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer(); // Open the end drawer
                },
              ),
            ),*/
            SizedBox(
              width: SizeConfig.width(5),
            ),
            // Add padding to the right for better spacing
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}