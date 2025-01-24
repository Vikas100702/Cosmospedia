import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

Widget buildDrawerItem(
    BuildContext context, {
      required IconData icon,
      required String title,
      required String route,
    }) {
  return ListTile(
    leading: Icon(
      icon,
      color: AppColors.textPrimaryDark, // Use dynamic color
      shadows: const [
        Shadow(
          color: AppColors.primaryLight,
          offset: Offset(0, 0),
          blurRadius: 6,
        ),
      ],
    ),
    title: Text(
      title,
      style: const TextStyle(
        color: AppColors.textPrimaryDark, // Use dynamic color
        shadows: [
          Shadow(
            color: AppColors.primaryLight,
            offset: Offset(0, 0),
            blurRadius: 6,
          ),
        ],
      ),
    ),
    tileColor: AppColors.transparentColor, // Make tile background transparent
    hoverColor: Colors.white.withOpacity(0.1), // Subtle highlight on hover
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, route);
    },
  );
}

