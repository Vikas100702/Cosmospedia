import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import 'app_drawer_widgets.dart';

//1.
/*
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
      backgroundColor: AppColors.drawerHeader,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.drawerHeader,
                  AppColors.drawerHeaderGradient,
                ],
              ),
            ),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          buildDrawerItem(
            context,
            icon: CupertinoIcons.settings,
            title: l10n.settings,
            route: "route",
          ),
          buildDrawerItem(
            context,
            icon: CupertinoIcons.globe,
            title: l10n.language,
            route: "route",
          ),
          buildDrawerItem(
            context,
            icon: CupertinoIcons.list_bullet,
            title: l10n.termConditions,
            route: "route",
          ),
          buildDrawerItem(
            context,
            icon: CupertinoIcons.doc_text,
            title: l10n.privacyPolicy,
            route: "route",
          ),
          buildDrawerItem(
            context,
            icon: CupertinoIcons.question_circle,
            title: l10n.helpSupport,
            route: "route",
          ),
          buildDrawerItem(
            context,
            icon: CupertinoIcons.power,
            title: l10n.logout,
            route: "route",
          ),
        ],
      ),
    );
  }
}*/

//2.
/*class CustomAppDrawer extends StatelessWidget {
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7), // semi-transparent dark background
          image: const DecorationImage(
            image: AssetImage('assets/background.png'), // Cosmic background image
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent, // Make header transparent
              ),
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
                    textScaleFactor: textScaleFactor,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28, // Increased font size
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.blueAccent,
                          offset: Offset(2, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ...[
              Icons.settings,
              Icons.language,
              Icons.list,
              Icons.privacy_tip,
              Icons.help,
              Icons.logout,
            ].asMap().entries.map((entry) {
              int idx = entry.key;
              IconData icon = entry.value;
              String title = [
                l10n.settings,
                l10n.language,
                l10n.termConditions,
                l10n.privacyPolicy,
                l10n.helpSupport,
                l10n.logout,
              ][idx];
              return buildDrawerItem(
                context,
                icon: icon,
                title: title,
                route: "route",
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}*/

//3.
/*class CustomAppDrawer extends StatelessWidget {
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7), // semi-transparent dark background
          image: const DecorationImage(
            image: AssetImage('assets/background.png'), // Cosmic background image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Blur effect layer
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5), // Overlay for depth
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.transparent, // Make header transparent
                  ),
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
                        textScaleFactor: textScaleFactor,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28, // Increased font size
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.blueAccent,
                              offset: Offset(2, 2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ...[
                  Icons.settings,
                  Icons.language,
                  Icons.list,
                  Icons.privacy_tip,
                  Icons.help,
                  Icons.logout,
                ].asMap().entries.map((entry) {
                  int idx = entry.key;
                  IconData icon = entry.value;
                  String title = [
                    l10n.settings,
                    l10n.language,
                    l10n.termConditions,
                    l10n.privacyPolicy,
                    l10n.helpSupport,
                    l10n.logout,
                  ][idx];
                  return buildDrawerItem(
                    context,
                    icon: icon,
                    title: title,
                    route: "route",
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/

//4.
/*class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing calculations
    final avatarRadius = screenWidth * 0.12; // 10% of screen width
    final textScaleFactor = screenWidth < 360 ? 0.8 : 1.0;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundDark.withOpacity(1), // Use dynamic color
          image: const DecorationImage(
            image: AssetImage('assets/background.png'), // Cosmic background image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Blur effect layer
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundDark.withOpacity(0.7), // Overlay for depth
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColors.transparentColor, // Make header transparent
                  ),
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
                        textScaleFactor: textScaleFactor,
                        style: const TextStyle(
                          color: AppColors.textPrimaryDark, // Use dynamic color
                          fontSize: 28, // Increased font size
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: AppColors.primaryLight,
                              offset: Offset(2, 2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ...[
                  Icons.settings,
                  Icons.language,
                  Icons.list,
                  Icons.privacy_tip,
                  Icons.help,
                  Icons.logout,
                ].asMap().entries.map((entry) {
                  int idx = entry.key;
                  IconData icon = entry.value;
                  String title = [
                    l10n.settings,
                    l10n.language,
                    l10n.termConditions,
                    l10n.privacyPolicy,
                    l10n.helpSupport,
                    l10n.logout,
                  ][idx];
                  return buildDrawerItem(
                    context,
                    icon: icon,
                    title: title,
                    route: "route",
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/

//5.
class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing calculations
    final avatarRadius = screenWidth * 0.2; // Increased to 20% of screen width
    final textScaleFactor = screenWidth < 360 ? 0.8 : 1.0;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundDark.withOpacity(1),
          image: const DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundDark.withOpacity(0.7),
              ),
            ),
            SingleChildScrollView(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: AppColors.transparentColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: CircleAvatar(
                            radius:
                                avatarRadius, // Updated avatar radius to 20%
                            backgroundImage:
                                const AssetImage('assets/logo.png'),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        FittedBox(
                          child: Text(
                            l10n!.appName,
                            textScaleFactor: textScaleFactor,
                            style: const TextStyle(
                              color: AppColors.textPrimaryDark,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: AppColors.primaryLight,
                                  offset: Offset(2, 2),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...[
                    Icons.settings,
                    Icons.language,
                    Icons.list,
                    Icons.privacy_tip,
                    Icons.help,
                    Icons.logout,
                  ].asMap().entries.map((entry) {
                    int idx = entry.key;
                    IconData icon = entry.value;
                    String title = [
                      l10n.settings,
                      l10n.language,
                      l10n.termConditions,
                      l10n.privacyPolicy,
                      l10n.helpSupport,
                      l10n.logout,
                    ][idx];
                    return buildDrawerItem(
                      context,
                      icon: icon,
                      title: title,
                      route: "route",
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
