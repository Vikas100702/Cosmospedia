import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

//1.
/*Widget buildDrawerItem(
    BuildContext context, {
      required IconData icon,
      required String title,
      required String route,
    }) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, route);
    },
  );
}*/

//2,3.
/*Widget buildDrawerItem(
    BuildContext context, {
      required IconData icon,
      required String title,
      required String route,
    }) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.white, // Light color for icons
      shadows: [
        Shadow(
          color: Colors.blueAccent,
          offset: Offset(0, 0),
          blurRadius: 6,
        ),
      ],
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.blueAccent,
            offset: Offset(0, 0),
            blurRadius: 6,
          ),
        ],
      ),
    ),
    tileColor: Colors.transparent, // Make tile background transparent
    hoverColor: Colors.white.withOpacity(0.1), // Subtle highlight on hover
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, route);
    },
  );
}*/

//4,5.
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

