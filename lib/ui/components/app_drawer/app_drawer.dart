import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import 'app_drawer_widgets.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing calculations
    final avatarRadius = screenWidth * 0.1; // 10% of screen width
    final headerHeight = screenHeight * 0.2; // 20% of screen height
    final textScaleFactor = screenWidth < 360 ? 0.8 : 1.0;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const AssetImage('assets/logo.png'),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  l10n!.appName,
                  textScaler: TextScaler.linear(textScaleFactor),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            route: '/',
          ),
          buildDrawerItem(
            context,
            icon: Icons.rocket,
            title: 'Missions',
            route: '/missions',
          ),
          buildDrawerItem(
            context,
            icon: Icons.image,
            title: 'APOD Gallery',
            route: '/apod',
          ),
          buildDrawerItem(
            context,
            icon: Icons.explore,
            title: 'Mars Rovers',
            route: '/rovers',
          ),
          /*buildDrawerItem(
            context,
            icon: Icons.track_changes,
            title: 'Near-Earth Objects',
            route: '/neos',
          ),
         buildDrawerItem(
            context,
            icon: Icons.event,
            title: 'Astronomical Events',
            route: '/events',
          ),*/
        ],
      ),
    );
  }
}