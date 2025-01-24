import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
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
    final avatarRadius = screenWidth * 0.2;
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
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CircleAvatar(
                              radius: screenHeight * 0.1, // Use 10% of screen height for avatar size
                              backgroundImage: const AssetImage('assets/logo.png'),
                            ),
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
