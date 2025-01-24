import 'package:cosmospedia/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

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
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
          size: 24,
        ),
        onPressed: () {
          // Open the drawer
          Scaffold.of(context).openDrawer();
        },
      ),
      centerTitle: true,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          l10n!.appName,
          style: TextStyle(
            color: AppColors.backgroundLight,
            fontWeight: FontWeight.w600,
            fontSize: screenSize.width * 0.045,
            letterSpacing: 0.5,
          ),
        ),
      ),
      actions: [
      /*  IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          onPressed: () {
            // Handle notification tap
          },
        ),*/
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}